enum QuestionType {
  multipleChoice,
  essay,
}

class Question {
  final QuestionType type;
  final String word;
  final String correctAnswer;
  final List<String>? options;

  Question({
    required this.type,
    required this.word,
    required this.correctAnswer,
    this.options,
  });
}

class QuizModel {
  final String quizId;
  final String moduleId; 
  final int numberOfQuestions;
  final List<Question> questionList;
  
  
  QuizModel({
    required this.quizId,
    required this.numberOfQuestions,
    required this.questionList,
    required this.moduleId,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    final questionList = (map['questionList'] as List<dynamic>)
        .map((item) => Question(
              type: QuestionType.values.firstWhere(
                (e) => e.name == item['type'],
              ),
              word: item['word'] as String,
              correctAnswer: item['correctAnswer'] as String,
              options: (item['options'] as List<dynamic>?)
                  ?.cast<String>()
                  .toList(),
            ))
        .toList();
    return QuizModel(
      quizId: map['quizId'] as String,
      numberOfQuestions: map['numberOfQuestions'] as int,
      questionList: questionList,
      moduleId: map['moduleId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'numberOfQuestions': numberOfQuestions,
      'questionList': questionList
          .map((item) => {
                'type': item.type.name,
                'word': item.word,
                'correctAnswer': item.correctAnswer,
                'options': item.options,
              })
          .toList(),
      'moduleId': moduleId,
    };
  }

  QuizModel copyWith({
    String? quizId,
    String? moduleId,
    int? numberOfQuestions,
    List<Question>? questionList,
  }) {
    return QuizModel(
      quizId: quizId ?? this.quizId,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      questionList: questionList ?? this.questionList,
      moduleId: moduleId ?? this.moduleId,
    );
  }
}