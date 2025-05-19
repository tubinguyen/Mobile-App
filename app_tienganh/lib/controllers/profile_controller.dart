import 'package:app_tienganh/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoadProfileController {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;


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

  Future<void> updateUserInfo(UserModel user) async {
    try {
      String userId = _auth.currentUser!.uid;

      await _firestore.collection('users').doc(userId).update(user.toMap());
    } catch (e) {
      print("Error: $e");
    }
  }
}
