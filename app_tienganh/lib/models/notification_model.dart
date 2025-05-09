class Notification {
  final String notificationId;
  final String mainText;
  final String subText;
  final DateTime timeAgo;
  final String svgPath;
  final DateTime createdAt;
  final String userId;

  Notification({
    required this.notificationId,
    required this.mainText,
    required this.subText,
    required this.timeAgo,
    required this.svgPath,
    required this.createdAt,
    required this.userId,
  });

  // Factory method để tạo đối tượng Notification từ một Map (ví dụ: từ API)
  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      notificationId: map['notificationId'] as String,
      mainText: map['mainText'] as String,
      subText: map['subText'] as String,
      // timeAgo: map['timeAgo'] as String,
       timeAgo: map['timeAgo'] is String
          ? DateTime.parse(map['timeAgo'] as String)
          : map['timeAgo'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['timeAgo'] as int)
              : DateTime.now(),
      svgPath: map['svgPath'] as String,
      createdAt: map['createdAt'] is String
          ? DateTime.parse(map['createdAt'] as String)
          : map['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.now(),
      userId: map['userId'] as String,
    );
  }

  // Phương thức để chuyển đổi đối tượng Notification thành Map (ví dụ: để gửi đến API)
  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'mainText': mainText,
      'subText': subText,
      'timeAgo': timeAgo,
      'svgPath': svgPath,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId, 
    };
  }

  // Các phương thức khác có thể hữu ích (ví dụ: copyWith)
  Notification copyWith({
    String? notificationId,
    String? mainText,
    String? subText,
    DateTime? timeAgo,
    String? svgPath,
    DateTime? createdAt,
    String? userId,
  }) {
    return Notification(
      notificationId: notificationId ?? this.notificationId,
      mainText: mainText ?? this.mainText,
      subText: subText ?? this.subText,
      timeAgo: timeAgo ?? this.timeAgo,
      svgPath: svgPath ?? this.svgPath,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }
}