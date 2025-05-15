import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tienganh/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      // Kiểm tra đăng ký người dùng mới
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Nếu đã tồn tại, sẽ không vào tới đây
      if (userCredential.user == null) {
        return "Lỗi: Không thể đăng ký.";
      }

      // Tạo ID người dùng tùy chỉnh
      String userId = userCredential.user!.uid;

      // Tạo đối tượng UserModel
      UserModel userModel = UserModel(
        userId: userId,
        email: email,
        username: username,
        role: 1,
        createdAt: DateTime.now(),
      );

      // Lưu thông tin người dùng vào Firestore
      await _firestore.collection('users').doc(userId).set(userModel.toMap());

      return "Đăng ký thành công!";
    } on FirebaseAuthException catch (e) {
      // Kiểm tra lỗi email đã tồn tại
      if (e.code == 'email-already-in-use') {
        return "Email đã tồn tại. Vui lòng sử dụng email khác!";
      } else if (e.code == 'weak-password') {
        return "Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn!";
      } else {
        return "Lỗi: ${e.message}";
      }
    } catch (e) {
      return "Đã có lỗi xảy ra.";
    }
  }
  //Dang xuat
  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return "Đăng xuất thành công!"; 
    } catch (e) {
      return "Lỗi: ${e.toString()}";
    }
  }

  Future<int?> getCurrentUserRole() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()?['role'] as int?;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
