import 'package:app_tienganh/widgets/banner.dart';
import 'package:app_tienganh/widgets/recent_activity.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/book_list.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    // Danh sách đường dẫn hình ảnh cho slideshow
    final List<String> images = [
      'assets/img/poster1.png',
      'assets/img/poster2.png',
      'assets/img/poster3.png',
      'assets/img/poster4.png',
      'assets/img/poster5.png',
      'assets/img/poster6.png',
    ];

    return Scaffold(
      // SafeArea đảm bảo nội dung không bị che bởi thanh trạng thái
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 1,
              ),
              child: Column(
                // MainAxisSize.min để Column chỉ chiếm không gian cần thiết
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Widget slideshow hiển thị hình ảnh
                  SlideshowWidget(
                    imagePaths: images,
                    duration: const Duration(seconds: 3),
                  ),

                  // Khoảng cách giữa các thành phần
                  const SizedBox(height: 20),

                  // Khối hoạt động gần đây
                  RecentActivity(
                    title: "Hoạt động gần đây",
                    status: "Đang học",
                    className: "Từ vựng TOIEC",
                    note: "Tiếp tục nào",
                    buttonText: "Xem chi tiết",
                    percentage: 72,
                    onTap: () {
                      //Điều hướng đến trang học phần đó
                      onNavigate(10);
                    },
                  ),

                  //Khoảng cách giữa các thành phần
                  const SizedBox(height: 20),

                  // Danh sách sách
                  BookList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
