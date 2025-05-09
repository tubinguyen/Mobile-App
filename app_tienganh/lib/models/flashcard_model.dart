class FlashcardModel {
  final String flashcardId;
  final String frontText;
  final String backText;
  bool isFlipped;
  final String moduleId;

  FlashcardModel({
    required this.flashcardId, 
    required this.frontText,
    required this.backText,
    this.isFlipped = false,
    required this.moduleId,
  });

  factory FlashcardModel.fromMap(Map<String, dynamic> map) {
    return FlashcardModel(
      flashcardId: map['flashcardId'] as String, 
      frontText: map['frontText'] as String,
      backText: map['backText'] as String,
      isFlipped: map['isFlipped'] as bool? ?? false,
      moduleId: map['moduleId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'flashcardId': flashcardId,
      'frontText': frontText,
      'backText': backText,
      'isFlipped': isFlipped,
      'moduleId': moduleId,
    };
  }

  FlashcardModel copyWith({
    String? flashcardId, 
    String? frontText,
    String? backText,
    bool? isFlipped,
    String? moduleId,
  }) {
    return FlashcardModel(
      flashcardId: flashcardId ?? this.flashcardId, 
      frontText: frontText ?? this.frontText,
      backText: backText ?? this.backText,
      isFlipped: isFlipped ?? this.isFlipped,
      moduleId: moduleId ?? this.moduleId,
    );
  }
}