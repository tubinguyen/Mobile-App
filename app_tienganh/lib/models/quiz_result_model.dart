class UserQuizResultModel {
  final String userId;
  final String quizId;
  final DateTime startTime;
  final DateTime endTime;
  final int correctAnswersCount;
  final int incorrectAnswersCount;
  final List<String> correctWords;
  final List<String> incorrectWords;
  final double completionPercentage;

  UserQuizResultModel({
    required this.userId,
    required this.quizId,
    required this.startTime,
    required this.endTime,
    required this.correctAnswersCount,
    required this.incorrectAnswersCount,
    required this.correctWords,
    required this.incorrectWords,
    required this.completionPercentage,
  });

  factory UserQuizResultModel.fromMap(Map<String, dynamic> map) {
    final startTimeTimestamp = map['startTime'];
    final endTimeTimestamp = map['endTime'];

    return UserQuizResultModel(
      userId: map['userId'] as String,
      quizId: map['quizId'] as String,
      startTime: startTimeTimestamp is String
          ? DateTime.parse(startTimeTimestamp)
          : startTimeTimestamp is int
              ? DateTime.fromMillisecondsSinceEpoch(startTimeTimestamp)
              : DateTime.now(),
      endTime: endTimeTimestamp is String
          ? DateTime.parse(endTimeTimestamp)
          : endTimeTimestamp is int
              ? DateTime.fromMillisecondsSinceEpoch(endTimeTimestamp)
              : DateTime.now(),
      correctAnswersCount: map['correctAnswersCount'] as int,
      incorrectAnswersCount: map['incorrectAnswersCount'] as int,
      correctWords: (map['correctWords'] as List<dynamic>).cast<String>().toList(),
      incorrectWords: (map['incorrectWords'] as List<dynamic>).cast<String>().toList(),
      completionPercentage: (map['completionPercentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'quizId': quizId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'correctAnswersCount': correctAnswersCount,
      'incorrectAnswersCount': incorrectAnswersCount,
      'correctWords': correctWords,
      'incorrectWords': incorrectWords,
      'completionPercentage': completionPercentage,
    };
  }

  UserQuizResultModel copyWith({
    String? userId,
    String? quizId,
    DateTime? startTime,
    DateTime? endTime,
    int? correctAnswersCount,
    int? incorrectAnswersCount,
    List<String>? correctWords,
    List<String>? incorrectWords,
    double? completionPercentage,
  }) {
    return UserQuizResultModel(
      userId: userId ?? this.userId,
      quizId: quizId ?? this.quizId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      correctAnswersCount: correctAnswersCount ?? this.correctAnswersCount,
      incorrectAnswersCount: incorrectAnswersCount ?? this.incorrectAnswersCount,
      correctWords: correctWords ?? this.correctWords,
      incorrectWords: incorrectWords ?? this.incorrectWords,
      completionPercentage: completionPercentage ?? this.completionPercentage,
    );
  }
}