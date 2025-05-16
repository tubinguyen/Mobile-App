import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tienganh/models/flashcard_model.dart';

class FlashCardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FlashcardModel>> getFlashcardsByModuleId(String moduleId) async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('learning_modules')
          .doc(moduleId)
          .get();

      // if (!snapshot.exists) {
      //   print("Module không tồn tại: $moduleId");
      //   return [];
      // }

      final data = snapshot.data() as Map<String, dynamic>;
      final List<dynamic> vocabularyData = data['vocabulary'] ?? [];

      return List.generate(vocabularyData.length, (index) {
        final item = vocabularyData[index] as Map<String, dynamic>;
        return FlashcardModel(
          flashcardId: index.toString(), // dùng index làm ID tạm
          frontText: item['word'] ?? '',
          backText: item['meaning'] ?? '',
          moduleId: moduleId,
        );
      });
    } catch (e) {
      print("Lỗi khi load flashcards: $e");
      return [];
    }
  }
}
