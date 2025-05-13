import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/user_model.dart';

class LearningModuleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  // Tạo học phần mới
  Future<String> createLearningModule({
    required String moduleName,
    String? description,
    required List<VocabularyItem> vocabulary,
  }) async {
    try {
      // Kiểm tra xem người dùng đã đăng nhập hay chưa
      if (_auth.currentUser == null) {
        return "Người dùng chưa đăng nhập.";
      }

      // Lấy ID người dùng hiện tại
      String userId = _auth.currentUser!.uid;

      // Tạo ID học phần tùy chỉnh
      String moduleId = DateTime.now().millisecondsSinceEpoch.toString();

      // Tạo đối tượng LearningModuleModel
      LearningModuleModel learningModuleModel = LearningModuleModel(
        moduleId: moduleId,
        userId: userId,
        moduleName: moduleName,
        description: description ?? '',
        vocabulary: vocabulary,
        totalWords: vocabulary.length,
        createdAt: DateTime.now(),
      );

      // Lưu thông tin học phần vào Firestore
      await _firestore.collection('learning_modules').doc(moduleId).set(learningModuleModel.toMap());

      // Đếm số lượng học phần của người dùng
      QuerySnapshot snapshot = await _firestore
          .collection('learning_modules')
          .where('userId', isEqualTo: userId)
          .get();

      int learningModuleCount = snapshot.docs.length;

      // Cập nhật learningModuleCount trong tài liệu người dùng
      await _firestore.collection('users').doc(userId).update({
        'learningModuleCount': learningModuleCount,
      });

      return moduleId;
    } catch (e) {
      // print("Error: $e"); // Debug lỗi
      return "Đã có lỗi xảy ra.";
    }
  }



  // Lấy thông tin người dùng từ Firestore
  Future<UserModel?> getUserInfo() async {
    try {
      if (_auth.currentUser == null) {
        return null;
      }

      String userId = _auth.currentUser!.uid;

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>, userId);
      }
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }



  // Lấy danh sách học phần của người dùng
  Future<List<LearningModuleModel>> getLearningModules() async {
    try {
      // Kiểm tra xem người dùng đã đăng nhập hay chưa
      if (_auth.currentUser == null) {
        return [];
      }

      // Lấy ID người dùng hiện tại
      String userId = _auth.currentUser!.uid;

      // Lấy danh sách học phần từ Firestore
      QuerySnapshot snapshot = await _firestore
          .collection('learning_modules')
          .where('userId', isEqualTo: userId)
          .get();

      // Chuyển đổi danh sách tài liệu thành danh sách đối tượng LearningModuleModel
          return snapshot.docs.map((doc) {
            return LearningModuleModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();
        } catch (e) {
          print("Error: $e");
          return [];
    }
  }



  // Lấy thông tin học phần theo ID
  Future<LearningModuleModel?> getLearningModuleById(String moduleId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('learning_modules').doc(moduleId).get();

      if (snapshot.exists) {
        return LearningModuleModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }



  //Xóa HP
  Future<void> deleteLearningModule(String moduleId) async {
    try {
      await _firestore.collection('learning_modules').doc(moduleId).delete();
    } catch (e) {
      print("Error: $e");
    }
  }

   
  // Cập nhật học phần
  Future<void> updateLearningModule({
    required String moduleId,
    required String moduleName,
    String? description,
    required List<VocabularyItem> vocabulary,
  }) async {
    try {
      // Kiểm tra xem người dùng đã đăng nhập hay chưa
      if (_auth.currentUser == null) {
        throw Exception("Người dùng chưa đăng nhập.");
      }

      // Cập nhật thông tin học phần trong Firestore
      await _firestore.collection('learning_modules').doc(moduleId).update({
        'moduleName': moduleName,
        'description': description ?? '',
        'vocabulary': vocabulary.map((vocab) => vocab.toMap()).toList(),
        'totalWords': vocabulary.length,
      });
    } catch (e) {
      print("Error: $e");
      throw Exception("Đã xảy ra lỗi khi cập nhật học phần.");
    }
  }
}