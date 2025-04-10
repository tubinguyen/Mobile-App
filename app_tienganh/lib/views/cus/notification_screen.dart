import 'package:app_tienganh/widgets/empty_notification.dart';
import 'package:app_tienganh/widgets/notification.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const NotificationScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    // Danh sách thông báo - bạn có thể lấy từ API hoặc state management
    final List<Map<String, String>> notifications = [
      {
        'mainText': 'Cùng trở lại học "vocab toeic week 1".',
        'subText': 'Tiếp tục nào!',
        'timeAgo': '9m',
        'svgPath': 'assets/img/Frame107.svg',
      },
      {
        'mainText': 'Cùng trở lại học "vocab toeic week 1".',
        'subText': 'Tiếp tục nào!',
        'timeAgo': '9m',
        'svgPath': 'assets/img/Frame107.svg',
      },
      {
        'mainText': 'Cùng trở lại học "vocab toeic week 1".',
        'subText': 'Tiếp tục nào!',
        'timeAgo': '9m',
        'svgPath': 'assets/img/Frame107.svg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0, // Loại bỏ đường shadow
      ),
      body:
          notifications.isEmpty
              ? Center(
                child: EmptyNotificationWidget(),
              ) // Chỉ empty nằm chính giữa
              : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return NotificationCard(
                    mainText: notifications[index]['mainText']!,
                    subText: notifications[index]['subText']!,
                    timeAgo: notifications[index]['timeAgo']!,
                    svgPath: notifications[index]['svgPath']!,
                  );
                },
              ),
    );
  }
}
