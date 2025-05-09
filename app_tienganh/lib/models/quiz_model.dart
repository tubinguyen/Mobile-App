enum QuestionType {
  trueFalse,
  multipleChoice,
  freeText,
}

class QuizModel {
  final String quizId;
  final int numberOfQuestions;
  final List<String> wordsInQuiz; // Danh sách các từ được chọn cho bài kiểm tra
  final QuestionType questionType;
  final String moduleId; 
  
  QuizModel({
    required this.quizId,
    required this.numberOfQuestions,
    required this.wordsInQuiz,
    required this.questionType,
    required this.moduleId,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      quizId: map['quizId'] as String,
      numberOfQuestions: map['numberOfQuestions'] as int,
      wordsInQuiz: (map['wordsInQuiz'] as List<dynamic>).cast<String>().toList(),
      questionType: QuestionType.values.byName(map['questionType'] as String),
      moduleId: map['moduleId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'numberOfQuestions': numberOfQuestions,
      'wordsInQuiz': wordsInQuiz,
      'questionType': questionType.name,
      'moduleId': moduleId,
    };
  }

  QuizModel copyWith({
    String? quizId,
    int? numberOfQuestions,
    List<String>? wordsInQuiz,
    QuestionType? questionType,
    String? moduleId,
  }) {
    return QuizModel(
      quizId: quizId ?? this.quizId,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      wordsInQuiz: wordsInQuiz ?? this.wordsInQuiz,
      questionType: questionType ?? this.questionType,
      moduleId: moduleId ?? this.moduleId,
    );
  }
}