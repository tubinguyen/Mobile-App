// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:app_tienganh/models/learning_module_model.dart';
// import 'package:app_tienganh/models/quiz_model.dart';
// import 'package:app_tienganh/models/quiz_result_model.dart';

// class QuizService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
//   // Lấy danh sách quiz của người dùng
//   Future<List<QuizModel>> getUserQuizzes() async {
//     try {
//       // Kiểm tra xem người dùng đã đăng nhập hay chưa
//       if (_auth.currentUser == null) {
//         return [];
//       }

//       // Lấy ID người dùng hiện tại
//       String userId = _auth.currentUser!.uid;

//       // Lấy danh sách quiz từ Firestore
//       QuerySnapshot snapshot = await _firestore
//           .collection('quizzes')
//           .where('userId', isEqualTo: userId)
//           .get();

//       List<QuizModel> quizzes = snapshot.docs.map((doc) {
//         return QuizModel.fromMap(doc.data() as Map<String, dynamic>);
//       }).toList();

//       return quizzes;
//     } catch (e) {
//       // print("Error: $e"); // Debug lỗi
//       return [];
//     }
//   }
//   // Lấy thông tin quiz từ Firestore
//   Future<QuizModel?> getQuizInfo(String quizId) async {
//     try {
//       // Lấy thông tin quiz từ Firestore
//       DocumentSnapshot quizDoc = await _firestore.collection('quizzes').doc(quizId).get();

//       if (quizDoc.exists) {
//         return QuizModel.fromMap(quizDoc.data() as Map<String, dynamic>);
//       }
//       return null;
//     } catch (e) {
//       // print("Error: $e"); // Debug lỗi
//       return null;
//     }
//   }
//   // Lưu kết quả quiz vào Firestore
//   Future<void> saveQuizResult({
//     required String quizId,
//     required String userId,
//     required int score,
//     required DateTime completedAt,
//   }) async {
//     try {
//       // Tạo ID kết quả quiz tùy chỉnh
//       String resultId = DateTime.now().millisecondsSinceEpoch.toString();

//       // Tạo đối tượng QuizResultModel
//       QuizResultModel quizResultModel = QuizResultModel(
//         resultId: resultId,
//         quizId: quizId,
//         userId: userId,
//         score: score,
//         completedAt: completedAt,
//       );

//       // Lưu thông tin kết quả quiz vào Firestore
//       await _firestore.collection('quiz_results').doc(resultId).set(quizResultModel.toMap());
//     } catch (e) {
//       // print("Error: $e"); // Debug lỗi
//     }
//   } 
//   // Lấy danh sách kết quả quiz của người dùng
//   Future<List<QuizResultModel>> getUserQuizResults() async {
//     try {
//       // Kiểm tra xem người dùng đã đăng nhập hay chưa
//       if (_auth.currentUser == null) {
//         return [];
//       }

//       // Lấy ID người dùng hiện tại
//       String userId = _auth.currentUser!.uid;

//       // Lấy danh sách kết quả quiz từ Firestore
//       QuerySnapshot snapshot = await _firestore
//           .collection('quiz_results')
//           .where('userId', isEqualTo: userId)
//           .get();

//       List<QuizResultModel> quizResults = snapshot.docs.map((doc) {
//         return QuizResultModel.fromMap(doc.data() as Map<String, dynamic>);
//       }).toList();

//       return quizResults;
//     } catch (e) {
//       // print("Error: $e"); // Debug lỗi
//       return [];
//     }
//   }
//   // Xóa quiz
//   Future<void> deleteQuiz(String quizId) async {
//     try {
//       // Xóa quiz khỏi Firestore
//       await _firestore.collection('quizzes').doc(quizId).delete();
//     } catch (e) {
//       // print("Error: $e"); // Debug lỗi
//     }
//   }
//   // Xóa kết quả quiz
//   Future<void> deleteQuizResult(String resultId) async {
//     try {
//       // Xóa kết quả quiz khỏi Firestore
//       await _firestore.collection('quiz_results').doc(resultId).delete();
//     } catch (e) {
//       // print("Error: $e"); // Debug lỗi
//     }
//   }
// }