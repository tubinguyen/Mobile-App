import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import '../../widgets/navbar.dart';
import '../../widgets/content_switch.dart';
import '../../widgets/empty_course.dart';
import '../../widgets/libraryobject.dart';
import '../../widgets/test_result_card.dart';

class ReviewScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const ReviewScreen({super.key, required this.onNavigate});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int selectedIndex = 0;

  Widget _buildContentForIndex(int index) {
    String subtitle = 'Học phần này được tạo bởi bạn'; // <-- giả lập DB
    String username = 'Nhi';
    switch (index) {
      case 0: // Học phần
        List<String> hocPhanList = [
          'Toán',
          'Lý',
          'Ngữ pháp cơ bản',
        ]; // <-- giả lập lấy từ DB

        if (hocPhanList.isEmpty) {
          return Center(
            child: EmptyCourse(
              title : 'Bạn chưa có học phần nào',
              subtitle : 'Các học phần bạn tạo sẽ được lưu tại đây',
              buttonText : 'Tạo học phần',
              imagePath : 'assets/img/book.png', // Default image path
              onButtonPressed : () {
                // Handle button press
                widget.onNavigate(3);
              },
              backgroundColor : AppColors.background,
              textColor : AppColors.textPrimary,
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
                    title: hocPhan,
                    subtitle: subtitle,
                    username: username,
                  ),
                  SizedBox(height: 12),
                ],
              );
            },
          );
        }

      case 1: // Kiểm tra
      //list ketqua gồm % hoàn thành, tên bài kiểm tra 
        List<Map<String, dynamic>> ketquaList = [ //code backend kq trả về 1 list dictionary
          {'title' : 'Kiểm tra từ vựng',
          'subtitle' : 'Ngữ pháp cơ bản',
          'progress' : 0.75, },

          {'title' : 'Kiểm tra ngữ pháp',
          'subtitle' : 'Ngữ pháp nâng cao', 
          'progress' : 0.50, },
          
        ]; // <-- giả lập lấy từ DB

        if (ketquaList.isEmpty) {
          return Center(
            //empty bai kiem tra
            child: EmptyCourse(
              title : 'Bạn chưa có bài kiểm tra nào',
              subtitle : 'Tìm và làm các bài kiểm tra thử dựa trên những gì bạn đang học',
              buttonText : 'Tìm kiếm bài kiểm tra',
              imagePath : 'assets/img/file_check_bold.png', // Default image path
              onButtonPressed : () {
                // Handle button press
                widget.onNavigate(3); //đang mặc định chưa chỉnh
              },
              backgroundColor : AppColors.background,
              textColor : AppColors.textPrimary,
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
                    )
              );
                  }
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
      padding: const EdgeInsets.symmetric(horizontal: 36), // ← Cách lề trái/phải 36
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
