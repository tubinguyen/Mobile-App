import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import '../../widgets/navbar.dart';
import '../../widgets/content_switch.dart';
import '../../widgets/empty_course.dart';
import '../../widgets/libraryobject.dart';
import '../../widgets/test_result_card.dart';
import 'package:app_tienganh/services/learning_module_service.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/user_model.dart';

class LibraryScreen extends StatefulWidget {
  final Function(int, {String? moduleId}) onNavigate; // Thêm moduleId làm tham số tùy chọn

  const LibraryScreen({super.key, required this.onNavigate});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int currentScreen = 0; // Quản lý màn hình hiện tại bằng currentScreen

  Widget _buildCourseScreen() {
    final LearningModuleService _getLearningModuleService = LearningModuleService();

    return FutureBuilder(
      future: Future.wait([
        _getLearningModuleService.getUserInfo(),
        _getLearningModuleService.getLearningModules(),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Đã xảy ra lỗi khi tải dữ liệu.",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          );
        }

        final userInfo = snapshot.data?[0] as UserModel?;
        final learningModules = snapshot.data?[1] as List<LearningModuleModel>;

        if (learningModules.isEmpty) {
          return Center(
            child: EmptyCourse(
              title: 'Bạn chưa có học phần nào',
              subtitle: 'Các học phần bạn tạo sẽ được lưu tại đây',
              buttonText: 'Tạo học phần',
              imagePath: 'assets/img/book.png',
              onButtonPressed: () {
                setState(() {
                  currentScreen = 3; // Điều hướng đến màn hình tạo học phần
                });
              },
              backgroundColor: AppColors.background,
              textColor: AppColors.textPrimary,
            ),
          );
        }

        // Sắp xếp danh sách learningModules theo createdAt tăng dần
        learningModules.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return ListView.builder(
          // padding: EdgeInsets.all(16),
          itemCount: learningModules.length,
          itemBuilder: (context, index) {
            final module = learningModules[index];

            // Tính toán thời gian hiển thị
            final now = DateTime.now();
            final difference = now.difference(module.createdAt);
            String date;
            if (difference.inMinutes < 60) {
              date = "${difference.inMinutes} phút trước";
            } else if (difference.inHours < 24) {
              date = "${difference.inHours} giờ trước";
            } else if (difference.inDays < 30) {
              date = "${difference.inDays} ngày trước";
            } else {
              date = "${module.createdAt.day}/${module.createdAt.month}/${module.createdAt.year}";
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0 || learningModules[index - 1].createdAt.day != module.createdAt.day)
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                LibraryObject(
                  title: module.moduleName,
                  subtitle: "${module.totalWords} từ vựng",
                  username: userInfo?.username ?? "Không rõ", // Lấy username từ UserModel
                  avatarUrl: userInfo?.avatarUrl, // Lấy avatarUrl từ UserModel
                  onTap: () {
                    setState(() {
                      widget.onNavigate(12, moduleId: module.moduleId); // Điều hướng đến màn hình chi tiết học phần
                    });
                  },
                ),
                SizedBox(height: 12),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTestResultScreen() {
    List<Map<String, dynamic>> ketquaList = [
      {'title': 'Kiểm tra từ vựng', 'subtitle': 'Ngữ pháp cơ bản', 'progress': 0.75},
      {'title': 'Kiểm tra ngữ pháp', 'subtitle': 'Ngữ pháp nâng cao', 'progress': 0.50},
    ];

    if (ketquaList.isEmpty) {
      return Center(
        child: EmptyCourse(
          title: 'Bạn chưa có bài kiểm tra nào',
          subtitle: 'Tìm và làm các bài kiểm tra thử dựa trên những gì bạn đang học',
          buttonText: 'Tìm kiếm bài kiểm tra',
          imagePath: 'assets/img/file_check_bold.png',
          onButtonPressed: () {
            setState(() {
              currentScreen = 3; // Điều hướng đến màn hình tìm kiếm bài kiểm tra
            });
          },
          backgroundColor: AppColors.background,
          textColor: AppColors.textPrimary,
        ),
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: ketquaList.length,
        itemBuilder: (context, index) {
          final ketqua = ketquaList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TestResultCard(
              title: ketqua['title'],
              subtitle: ketqua['subtitle'],
              progress: ketqua['progress'],
            ),
          );
        },
      );
    }
  }

  Widget _buildContentForCurrentScreen() {
    switch (currentScreen) {
      case 0:
        return _buildCourseScreen();
      case 1:
        return _buildTestResultScreen();
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: CustomNavBar(
              title: "Thư viện của bạn",
              leadingIconPath: "assets/img/back.svg",
              onLeadingPressed: () {
                resetPage();
                widget.onNavigate(0); // Điều hướng về màn hình chính
              },
            ),
          ),
          ContentSwitcher(
            selectedIndex: currentScreen,
            onNavigate: (index) {
              setState(() {
                currentScreen = index; // Cập nhật màn hình hiện tại
              });
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: _buildContentForCurrentScreen(),
            ),
          ),
        ],
      ),
    );
  }

  void resetPage() {
    setState(() {
      currentScreen = 0;   
    });
  }
}
