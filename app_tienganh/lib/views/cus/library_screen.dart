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
      case 0: 
        List<Map<String, dynamic>> hocPhanList = [
          {'id': 1, 'title': 'Toán', 'createdAt': DateTime(2024,5,4)}, //Lúc code backend nhớ truyền CreatedAt để nhóm học phần theo ngày
          {'id': 2, 'title': 'Lý','createdAt': DateTime(2024,5,4)},
          {'id': 3, 'title': 'Ngữ pháp cơ bản', 'createdAt': DateTime(2024,5,1)},
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
          //Nhóm theo ngày
          Map <String, List<Map>> groupedByDate = {};
          for (var hocphan in hocPhanList)
          {
            final DateTime date = hocphan['createdAt'];
            final dateKey = "${date.day}/${date.month}/${date.year}";
            groupedByDate.putIfAbsent(dateKey, () => []).add(hocphan);
          }

          final dateKeys = groupedByDate.keys.toList();

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: dateKeys.length,
            itemBuilder: (context, index) {
              final date = dateKeys[index];
              final hocPhan = groupedByDate[date]!;

              return Center (
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      SizedBox(height: 10,),
                      Text(
                        "Ngày tạo: $date",
                        style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        )
                      ),
                      ...hocPhan.map((hocPhan)
                      {
                        return Column (
                          children: [
                            SizedBox(height: 12),
                            LibraryObject(
                              hocphanID: hocPhan['id'],
                              title: hocPhan['title'],
                              subtitle: subtitle,
                              username: username,
                              onTap: () {
                                widget.onNavigate(20); // Điều hướng
                              },
                        ),
                          ],);
                      }).toList(),

                      
                  
                  
                ],
              )
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
          return Center (
            child : ListView.builder(
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
          )
          );
        }

      default:
        return SizedBox.shrink();
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // Thêm Center ở đây
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: CustomNavBar(
                title: "Thư viện của bạn",
                leadingIconPath: "assets/img/back.svg",
                onLeadingPressed: () {
                  widget.onNavigate(0);
                },
              ),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: _buildContentForIndex(selectedIndex),
              ),
            ),
          ],
        ),
      ),
    );
    }
}
