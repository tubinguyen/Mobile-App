import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import '../../widgets/navbar.dart';
import '../../widgets/content_switch.dart';
import '../../widgets/empty_course.dart';
import '../../widgets/libraryobject.dart';
import '../../widgets/test_result_card.dart';

class LibraryScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const LibraryScreen({super.key, required this.onNavigate});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  int selectedIndex = 0;

  Widget _buildContentForIndex(int index) {
    String subtitle = 'Học phần này được tạo bởi bạn';
    String username = 'Nhi';

    switch (index) {
      case 0: // Học phần
        List<Map<String, dynamic>> hocPhanList = [
          {'id': 1, 'title': 'Toán'},
          {'id': 2, 'title': 'Lý'},
          {'id': 3, 'title': 'Ngữ pháp cơ bản'},
        ];

        if (hocPhanList.isEmpty) {
          return Center(
            child: EmptyCourse(
              title: 'Bạn chưa có học phần nào',
              subtitle: 'Các học phần bạn tạo sẽ được lưu tại đây',
              buttonText: 'Tạo học phần',
              imagePath: 'assets/img/book.png',
              onButtonPressed: () {
                widget.onNavigate(3);
              },
              backgroundColor: AppColors.background,
              textColor: AppColors.textPrimary,
            ),
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: hocPhanList.length,
            itemBuilder: (context, index) {
              final hocPhan = hocPhanList[index];
              return Column(
                children: [
                      LibraryObject(
                      hocphanID: hocPhan['id'],
                      title: hocPhan['title'],
                      subtitle: subtitle,
                      username: username,
                      onTap: () {
                        widget.onNavigate(11); // Điều hướng
                      },
                    ),
                  
                  SizedBox(height: 12),
                ],
              );
            },
          );
        }

      case 1: // Kiểm tra
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
                widget.onNavigate(3);
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

      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          children: [
            CustomNavBar(
              title: "Thư viện của bạn",
              leadingIconPath: "assets/img/back.svg",
              actionIconPath: " ",
              onLeadingPressed: () {
                Navigator.pop(context);
              },
              onActionPressed: () {
                widget.onNavigate(3);
              },
            ),
            ContentSwitcher(
              selectedIndex: selectedIndex,
              onNavigate: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            SizedBox(height: 40),
            Expanded(child: _buildContentForIndex(selectedIndex)),
          ],
        ),
      ),
    );
  }
}