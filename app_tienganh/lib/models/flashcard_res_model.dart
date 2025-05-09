class FlashcardQuizResultModel {
  final String userId;       
  final String moduleId;    
  final DateTime startTime;   
  final int correctWordCount;
  final int totalWordCount;  
  final double completionPercentage;

  FlashcardQuizResultModel({
    required this.userId,
    required this.moduleId,
    required this.startTime,
    required this.correctWordCount,
    required this.totalWordCount,
    required this.completionPercentage,
  });

  factory FlashcardQuizResultModel.fromMap(Map<String, dynamic> map) {
    final startTimeTimestamp = map['startTime'];

    return FlashcardQuizResultModel(
      userId: map['userId'] as String,
      moduleId: map['moduleId'] as String,
      startTime: startTimeTimestamp is String
          ? DateTime.parse(startTimeTimestamp)
          : startTimeTimestamp is int
              ? DateTime.fromMillisecondsSinceEpoch(startTimeTimestamp)
              : DateTime.now(),
      correctWordCount: map['correctWordCount'] as int,
      totalWordCount: map['totalWordCount'] as int,
      completionPercentage: (map['completionPercentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'moduleId': moduleId,
      'startTime': startTime.toIso8601String(),
      'correctWordCount': correctWordCount,
      'totalWordCount': totalWordCount,
      'completionPercentage': completionPercentage,
    };
  }

  FlashcardQuizResultModel copyWith({
    String? userId,
    String? moduleId,
    DateTime? startTime,
    int? correctWordCount,
    int? totalWordCount,
    double? completionPercentage,
  }) {
    return FlashcardQuizResultModel(
      userId: userId ?? this.userId,
      moduleId: moduleId ?? this.moduleId,
      startTime: startTime ?? this.startTime,
      correctWordCount: correctWordCount ?? this.correctWordCount,
      totalWordCount: totalWordCount ?? this.totalWordCount,
      completionPercentage: completionPercentage ?? this.completionPercentage,
    );
  }
}