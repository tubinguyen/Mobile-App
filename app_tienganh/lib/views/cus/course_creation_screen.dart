import 'package:flutter/material.dart';
import '../../widgets/header.dart';
import '../../widgets/top_app_bar.dart';
import '../../widgets/notification.dart';

class CourseCreationScreen extends StatelessWidget {
final Function(int) onNavigate;
  const CourseCreationScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(
          onHomeTap: () {
            onNavigate(0); // Navigate to home screen
          },
          onNotificationTap: () {
            onNavigate(1); // Navigate to notification screen
          },
          onAuthTap: () {
            onNavigate(2); // Navigate to auth screen
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            NotificationCard(
              mainText: 'Bạn chưa có học phần nào',
              subText: 'các học phần bạn tạo sẽ được lưu tại đây',
              timeAgo: '9m',
              svgPath: 'assets/img/book.png',
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            ),
          ],
        ),
      ),
    );
  }
}