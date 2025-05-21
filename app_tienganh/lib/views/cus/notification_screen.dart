import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/models/notification_model.dart';
import 'package:app_tienganh/controllers/notification_controller.dart';
import 'package:app_tienganh/widgets/empty_notification.dart';
import 'package:app_tienganh/widgets/notification.dart' as widgets;
import 'package:app_tienganh/core/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  final Function(int) onNavigate;
  final String userId;

  NotificationScreen({
    super.key,
    required this.onNavigate,
    required this.userId,
  }) {
    print('NotificationScreen: Khởi tạo với userId: $userId');
    if (userId.isEmpty) {
      print('Cảnh báo: userId rỗng, thử lấy từ FirebaseAuth');
      final authUserId = FirebaseAuth.instance.currentUser?.uid;
      if (authUserId == null) {
        print('Lỗi: Người dùng chưa đăng nhập');
      } else {
        print('Lấy userId từ FirebaseAuth: $authUserId');
      }
    }
  }

  final NotificationController _notificationController =
      NotificationController();

  @override
  Widget build(BuildContext context) {
    final effectiveUserId =
        userId.isNotEmpty
            ? userId
            : FirebaseAuth.instance.currentUser?.uid ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<AppNotification>>(
        stream: _notificationController.getNotificationsStream(effectiveUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Lỗi khi tải thông báo'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: EmptyNotificationWidget());
          }
          final notifications = snapshot.data!;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return widgets.NotificationCard(
                mainText: notification.mainText,
                subText: notification.subText,
                timeAgo: notification.timeAgoString,
                svgPath: notification.svgPath,
              );
            },
          );
        },
      ),
    );
  }
}
