import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class EditProfileController {
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(userId).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Lỗi khi lấy dữ liệu người dùng: $e');
      return null;
    }
  }

  // Upload ảnh lên server riêng, trả về URL ảnh
  Future<String?> uploadImageToMyCloud(File? imageFile) async {
    if (imageFile == null) return null;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://13.212.35.60:8080/api/s3/upload'),
      );

      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        var imageUrl = await response.stream.bytesToString();
        return imageUrl;
      } else {
        print('Upload ảnh thất bại với mã: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi khi upload ảnh lên cloud riêng: $e');
      return null;
    }
  }

  // Cập nhật URL ảnh trong Firestore
  Future<bool> updateImage(String userId, String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'imageUrl': imageUrl,
      });
      return true;
    } catch (e) {
      print('Lỗi khi cập nhật ảnh đại diện: $e');
      return false;
    }
  }
}