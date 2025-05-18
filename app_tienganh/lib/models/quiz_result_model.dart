import 'quiz_model.dart';
class QuestionResult {
  final int index;
  final QuestionType type;
  final String word;
  final String correctAnswer;
  String? userAnswer;
  final List<String>? options;
  final bool? isCorrect;

  QuestionResult({this.index = 0, required this.type, required this.word, required this.correctAnswer, this.userAnswer, this.options, this.isCorrect});
}

class QuizResultModel {
  final String quizResultId;
  final String quizId;
  final String moduleId;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final int correctAnswersCount;
  final int incorrectAnswersCount;
  final double completionPercentage;
  final List<QuestionResult> questionResults;

  QuizResultModel({
    required this.quizResultId,
    required this.quizId,
    required this.moduleId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.correctAnswersCount,
    required this.incorrectAnswersCount,
    required this.completionPercentage,
    required this.questionResults,
  });

  factory QuizResultModel.fromMap(Map<String, dynamic> map) {
    final startTimeTimestamp = map['startTime'];
    final endTimeTimestamp = map['endTime'];
    final questionResults = (map['questionResults'] as List<dynamic>)
        .map((item) => QuestionResult(
              index: item['index'] as int,
              type: QuestionType.values.firstWhere(
                (e) => e.name == item['type'],
              ),
              word: item['word'] as String,
              correctAnswer: item['correctAnswer'] as String,
              userAnswer: item['userAnswer'] as String?,
              options: (item['options'] as List<dynamic>?)?.cast<String>(),
              isCorrect: item['isCorrect'] as bool?,
            ))
        .toList();

    return QuizResultModel(
      quizResultId: map['quizResultId'] as String,
      quizId: map['quizId'] as String,
      moduleId: map['moduleId'] as String,
      userId: map['userId'] as String,
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
      completionPercentage: (map['completionPercentage'] as num).toDouble(),
      questionResults: questionResults,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quizResultId': quizResultId,
      'quizId': quizId,
      'moduleId': moduleId,
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'correctAnswersCount': correctAnswersCount,
      'incorrectAnswersCount': incorrectAnswersCount,
      'completionPercentage': completionPercentage,
      'questionResults': questionResults
          .map((item) => {
                'index': item.index,
                'type': item.type.name,
                'word': item.word,
                'correctAnswer': item.correctAnswer,
                'userAnswer': item.userAnswer,
                'options': item.options,
                'isCorrect': item.isCorrect,
              })
          .toList(),
    };
  }

  QuizResultModel copyWith({
    String? quizResultId,
    String? quizId,
    String? moduleId,
    String? userId,
    DateTime? startTime,
    DateTime? endTime,
    int? correctAnswersCount,
    int? incorrectAnswersCount,
    double? completionPercentage,
    List<QuestionResult>? questionResults,
  }) {
    return QuizResultModel(
      quizResultId: quizResultId ?? this.quizResultId,
      quizId: quizId ?? this.quizId,
      moduleId: moduleId ?? this.moduleId,
      userId: userId ?? this.userId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      correctAnswersCount: correctAnswersCount ?? this.correctAnswersCount,
      incorrectAnswersCount: incorrectAnswersCount ?? this.incorrectAnswersCount,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      questionResults: questionResults ?? this.questionResults,
    );
  }
}