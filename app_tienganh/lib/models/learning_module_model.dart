class VocabularyItem {
  final String word;
  final String meaning;

  VocabularyItem({required this.word, required this.meaning});

  factory VocabularyItem.fromMap(Map<String, dynamic> map) {
    return VocabularyItem(
      word: map['word'] as String,
      meaning: map['meaning'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'meaning': meaning,
    };
  }
}

class LearningModuleModel {
  final String moduleId;
  final String moduleName;
  final String? description;
  final List<VocabularyItem> vocabulary;
  final int totalWords; 
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  LearningModuleModel({
    required this.moduleId,
    required this.moduleName,
    this.description,
    required this.vocabulary,
    required this.totalWords,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

 factory LearningModuleModel.fromMap(Map<String, dynamic> map) {
    final vocabularyList = (map['vocabulary'] as List<dynamic>)
        .map((item) => VocabularyItem.fromMap(item as Map<String, dynamic>))
        .toList();

    return LearningModuleModel(
      moduleId: map['moduleId'] as String,
      moduleName: map['moduleName'] as String,
      description: map['description'] as String?,
      vocabulary: vocabularyList,
      userId: map['userId'] as String,
      createdAt: map['createdAt'] is String
          ? DateTime.parse(map['createdAt'] as String)
          : map['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.now(),
      totalWords: map['totalWords'] as int? ?? vocabularyList.length, 
      updatedAt: map['updatedAt'] is String
          ? DateTime.parse(map['updatedAt'] as String)
          : map['updatedAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'moduleId': moduleId,
      'moduleName': moduleName,
      'description': description,
      'vocabulary': vocabulary.map((item) => item.toMap()).toList(),
      'totalWords': totalWords,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  LearningModuleModel copyWith({
    String? moduleId,
    String? moduleName,
    String? description,
    List<VocabularyItem>? vocabulary,
    int? totalWords,
    String? creatorId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LearningModuleModel(
      moduleId: moduleId ?? this.moduleId,
      moduleName: moduleName ?? this.moduleName,
      description: description ?? this.description,
      vocabulary: vocabulary ?? this.vocabulary,
      totalWords: totalWords ?? this.totalWords,
      userId: creatorId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}