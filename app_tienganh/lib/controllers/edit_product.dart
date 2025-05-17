import 'package:app_tienganh/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

class EditProductController {
  // Lấy dữ liệu sản phẩm từ Firestore
  Future<Map<String, dynamic>?> getProductData(String productId) async {
    try {
      DocumentSnapshot productSnapshot =
          await FirebaseFirestore.instance
              .collection('Books')
              .doc(productId)
              .get();

      if (productSnapshot.exists) {
        return productSnapshot.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Error fetching product data: $e');
      return null;
    }
  }

  // Upload ảnh lên server riêng, trả về URL ảnh
  Future<String?> uploadImageToMyCloud(File? imageFile) async {
    if (imageFile == null) return null;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'http://ec2-13-212-75-127.ap-southeast-1.compute.amazonaws.com:8080/api/s3/upload',
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
      var response = await request.send();

      if (response.statusCode == 200) {
        // Trả về trực tiếp chuỗi response làm URL
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

  // Cập nhật sản phẩm trong Firestore
  Future<bool> updateProduct(String productId, Book book) async {
    try {
      await FirebaseFirestore.instance
          .collection('Books')
          .doc(productId)
          .update(book.toMap());
      return true;
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }
}
