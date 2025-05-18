import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tienganh/models/quiz_model.dart';
import 'package:app_tienganh/models/quiz_result_model.dart';

class QuizController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Tạo một quiz mới với moduleId
  Future<String> createQuiz({
    required String moduleId,
    required int numberOfQuestions,
    required List<Question> questionList,
  }) async {
    try {
      // Kiểm tra xem người dùng đã đăng nhập hay chưa
      if (_auth.currentUser == null) {
        return "Người dùng chưa đăng nhập.";
      }

      // Tạo ID quiz tùy chỉnh
      String quizId = DateTime.now().millisecondsSinceEpoch.toString();

      // Tạo đối tượng QuizModel
      QuizModel quizModel = QuizModel(
        quizId: quizId,
        moduleId: moduleId,
        numberOfQuestions: numberOfQuestions,
        questionList: questionList,
      );

      // Lưu thông tin quiz vào Firestore
      await _firestore.collection('quizzes').doc(quizId).set(quizModel.toMap());

      return quizId;
    } catch (e) {
      // print("Error: $e"); // Debug lỗi
      return "Lỗi khi tạo quiz.";
    }
  }


  //Lưu kết quả quiz với quizId
  Future<String> saveQuizResult({
    required String quizId,
    required String moduleId,
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    required int correctAnswersCount,
    required int incorrectAnswersCount,
    required double completionPercentage,
    required List<QuestionResult> questionResults,
  }) async {
    try {
      // Tạo ID kết quả quiz tùy chỉnh
      String quizResultId = DateTime.now().millisecondsSinceEpoch.toString();

      // Tạo đối tượng QuizResultModel
      QuizResultModel quizResultModel = QuizResultModel(
        quizResultId: quizResultId,
        quizId: quizId,
        moduleId: moduleId, 
        userId: _auth.currentUser!.uid,
        startTime: startTime,
        endTime: endTime,
        correctAnswersCount: correctAnswersCount, 
        incorrectAnswersCount: incorrectAnswersCount,
        completionPercentage: completionPercentage,
        questionResults: questionResults,
      );

      // Lưu thông tin kết quả quiz vào Firestore
      await _firestore.collection('quiz_results').doc(quizResultId).set(quizResultModel.toMap());

      return quizResultId;
    } catch (e) {
      // print("Error: $e"); // Debug lỗi
      return "Lỗi khi lưu kết quả quiz.";
    }
  }

  //Lấy danh sách kết quả quiz từ Firestore theo quizResultId
  Future<QuizResultModel?> getQuizResultByQuizResultId(String quizResultId) async {
    final doc = await FirebaseFirestore.instance
        .collection('quiz_results')
        .doc(quizResultId)
        .get();
    if (!doc.exists) return null;
    return QuizResultModel.fromMap(doc.data()!);
  }


  //Xóa quiz theo quizId
  Future<void> deleteQuiz(String quizId) async {
    try {
      await _firestore.collection('quizzes').doc(quizId).delete();
    } catch (e) {
      // print("Error: $e"); // Debug lỗi
    }
  }


  // QuizController
  Future<List<QuizResultModel>> getQuizResultsOfCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];
    final snapshot = await FirebaseFirestore.instance
        .collection('quiz_results')
        .where('userId', isEqualTo: user.uid) // hoặc trường bạn lưu user
        .get();
    return snapshot.docs.map((doc) => QuizResultModel.fromMap(doc.data())).toList();
  }


  // Xóa tất cả quiz và quiz_result của một moduleId
  Future<void> deleteAllQuizAndResultsByModuleId(String moduleId) async {
    // Xóa tất cả quiz của moduleId này
    final quizSnapshot = await _firestore
        .collection('quizzes')
        .where('moduleId', isEqualTo: moduleId)
        .get();
    for (var doc in quizSnapshot.docs) {
      await _firestore.collection('quizzes').doc(doc.id).delete();
    }

    // Xóa tất cả quiz_result của moduleId này
    final quizResultSnapshot = await _firestore
        .collection('quiz_results')
        .where('moduleId', isEqualTo: moduleId)
        .get();
    for (var doc in quizResultSnapshot.docs) {
      await _firestore.collection('quiz_results').doc(doc.id).delete();
    }
  }
}