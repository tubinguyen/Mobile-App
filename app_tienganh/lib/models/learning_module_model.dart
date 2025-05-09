enum ViewStatus {
  everyone,
  onlyMe,
}

enum EditStatus {
  everyone,
  onlyMe,
}

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
  final ViewStatus viewStatus;
  final EditStatus editStatus;
  final String userId;
  final DateTime createdAt;

  LearningModuleModel({
    required this.moduleId,
    required this.moduleName,
    this.description,
    required this.vocabulary,
    required this.totalWords,
    required this.viewStatus,
    required this.editStatus,
    required this.userId,
    required this.createdAt,
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
      viewStatus: ViewStatus.values.byName(map['viewStatus'] as String),
      editStatus: EditStatus.values.byName(map['editStatus'] as String),
      userId: map['userId'] as String,
      createdAt: map['createdAt'] is String
          ? DateTime.parse(map['createdAt'] as String)
          : map['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.now(),
      totalWords: map['totalWords'] as int? ?? vocabularyList.length, 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'moduleId': moduleId,
      'moduleName': moduleName,
      'description': description,
      'vocabulary': vocabulary.map((item) => item.toMap()).toList(),
      'totalWords': totalWords,
      'viewStatus': viewStatus.name,
      'editStatus': editStatus.name,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  LearningModuleModel copyWith({
    String? moduleId,
    String? moduleName,
    String? description,
    List<VocabularyItem>? vocabulary,
    int? totalWords,
    ViewStatus? viewStatus,
    EditStatus? editStatus,
    String? creatorId,
    DateTime? createdAt,
  }) {
    return LearningModuleModel(
      moduleId: moduleId ?? this.moduleId,
      moduleName: moduleName ?? this.moduleName,
      description: description ?? this.description,
      vocabulary: vocabulary ?? this.vocabulary,
      totalWords: totalWords ?? this.totalWords,
      viewStatus: viewStatus ?? this.viewStatus,
      editStatus: editStatus ?? this.editStatus,
      userId: creatorId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}