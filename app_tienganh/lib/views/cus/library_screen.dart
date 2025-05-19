import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import '../../widgets/navbar.dart';
import '../../widgets/content_switch.dart';
import '../../widgets/empty_course.dart';
import '../../widgets/libraryobject.dart';
import '../../widgets/test_result_card.dart';
import 'package:app_tienganh/controllers/learning_module_controller.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/user_model.dart';
import 'package:app_tienganh/models/quiz_result_model.dart';
import 'package:app_tienganh/controllers/quiz_controller.dart';

class LibraryScreen extends StatefulWidget {
  final Function(int, {String? moduleId, String? quizResultId}) onNavigate; // Thêm moduleId làm tham số tùy chọn
  final int? currentScreen;
  const LibraryScreen({super.key, required this.onNavigate, this.currentScreen});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  // lấy currentScreen từ widget
  int currentScreen = 0; // Quản lý màn hình hiện tại bằng currentScreen
  final LearningModuleController _getLearningModuleController = LearningModuleController();
  List<LearningModuleModel> _learningModules = [];

  Widget _buildCourseScreen() {
    return FutureBuilder(
      future: Future.wait([
        _getLearningModuleController.getUserInfo(),
        _getLearningModuleController.getLearningModules(),
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

        _learningModules = learningModules;

        if (learningModules.isEmpty) {
          return Center(
            child: EmptyCourse(
              title: 'Bạn chưa có học phần nào',
              subtitle: 'Các học phần bạn tạo sẽ được lưu tại đây',
              buttonText: 'Tạo học phần',
              imagePath: 'assets/img/book.png',
              onButtonPressed: () {
                setState(() {
                  widget.onNavigate(2); 
                });
              },
              backgroundColor: AppColors.background,
              textColor: AppColors.textPrimary,
            ),
          );
        }

        // Sắp xếp danh sách learningModules theo createdAt tăng dần
        learningModules.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

        return ListView.builder(
          // padding: EdgeInsets.all(16),
          itemCount: learningModules.length,
          itemBuilder: (context, index) {
            final module = learningModules[index];

            // Tính toán thời gian hiển thị
            final now = DateTime.now();
            final difference = now.difference(module.updatedAt);
            String date;
            if (difference.inMinutes < 60) {
              date = "${difference.inMinutes} phút trước";
            } else if (difference.inHours < 24) {
              date = "${difference.inHours} giờ trước";
            } else if (difference.inDays < 30) {
              date = "${difference.inDays} ngày trước";
            } else {
              date = "${module.updatedAt.day}/${module.updatedAt.month}/${module.updatedAt.year}";
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0 || learningModules[index - 1].updatedAt.day != module.updatedAt.day)
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
    return FutureBuilder<List<QuizResultModel>>(
      future: QuizController().getQuizResultsOfCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: EmptyCourse(
              title: 'Bạn chưa có bài kiểm tra nào',
              subtitle: 'Tìm và làm các bài kiểm tra thử dựa trên những gì bạn đang học',
              buttonText: 'Tìm kiếm bài kiểm tra',
              imagePath: 'assets/img/file_check_bold.png',
              onButtonPressed: () {
                setState(() {
                  currentScreen = 0;
                });
              },
              backgroundColor: AppColors.background,
              textColor: AppColors.textPrimary,
            ),
          );
        }
        final ketquaList = snapshot.data!;
        // Sắp xếp danh sách ketquaList theo endTime giảm dần
        ketquaList.sort((a, b) => b.endTime.compareTo(a.endTime));
        
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
          itemCount: ketquaList.length,
          itemBuilder: (context, index) {
            final ketqua = ketquaList[index];
            // Tìm moduleName theo moduleId
            final module = _learningModules.firstWhere(
              (m) => m.moduleId == ketqua.moduleId,
              orElse: () => LearningModuleModel(
                moduleId: ketqua.moduleId,
                moduleName: 'Không rõ',
                vocabulary: [],
                totalWords: 0,
                userId: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );
            return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: () {
                  widget.onNavigate(
                    23,
                    quizResultId: ketqua.quizResultId,
                    moduleId: ketqua.moduleId,
                  );
                },
                child: TestResultCard(
                  title: "Kiểm tra ${module.moduleName}", 
                  subtitle: "Số câu đúng: ${ketqua.correctAnswersCount}/${ketqua.questionResults.length}",
                  date: ketqua.endTime,
                  progress: ketqua.completionPercentage / 100,
                  moduleId: ketqua.moduleId,
                ),
              ),
            );
          },
        );
      },
    );
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
      appBar: CustomNavBar(
        title: "Thư viện của bạn",
        leadingIconPath: 'assets/img/back.svg',
        onLeadingPressed: () {
          resetPage();
          widget.onNavigate(0); // Điều hướng về màn hình chính
        },
      ),

      body: Column(
        children: [
          const SizedBox(height: 16),
          ContentSwitcher(
            selectedIndex: currentScreen,
            onNavigate: (index) {
              setState(() {
                currentScreen = index; // Cập nhật màn hình hiện tại
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0), 
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
