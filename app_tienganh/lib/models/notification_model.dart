import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String notificationId;
  final String mainText;
  final String subText;
  final String svgPath;
  final DateTime createdAt;
  final String userId;

  AppNotification({
    required this.notificationId,
    required this.mainText,
    required this.subText,
    required this.svgPath,
    required this.createdAt,
    required this.userId,
  });

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      notificationId: map['notificationId'] as String,
      mainText: map['mainText'] as String,
      subText: map['subText'] as String,
      svgPath: map['svgPath'] as String,
      createdAt:
          (map['createdAt'] is Timestamp
              ? (map['createdAt'] as Timestamp).toDate()
              : map['createdAt'] is String
              ? DateTime.tryParse(map['createdAt'] as String) ?? DateTime.now()
              : DateTime.now()),
      userId: map['userId'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'mainText': mainText,
      'subText': subText,
      'svgPath': svgPath,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
    };
  }

  AppNotification copyWith({
    String? notificationId,
    String? mainText,
    String? subText,
    String? svgPath,
    DateTime? createdAt,
    String? userId,
  }) {
    return AppNotification(
      notificationId: notificationId ?? this.notificationId,
      mainText: mainText ?? this.mainText,
      subText: subText ?? this.subText,
      svgPath: svgPath ?? this.svgPath,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  String get timeAgoString {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) return 'Vừa xong';
    if (difference.inMinutes < 60) return '${difference.inMinutes} phút trước';
    if (difference.inHours < 24) return '${difference.inHours} giờ trước';
    return '${difference.inDays} ngày trước';
  }
}
