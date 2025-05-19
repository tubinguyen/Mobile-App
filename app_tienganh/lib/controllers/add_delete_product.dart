import 'dart:io';
import 'package:app_tienganh/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class ProductController {
  final CollectionReference _productsRef = FirebaseFirestore.instance
      .collection('Books');

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

  // Thêm sản phẩm vào Firestore
  Future<void> addProduct(Book book) async {
    await _productsRef.add(book.toMap());
  }

  // Xóa sản phẩm theo productId
  Future<void> deleteProduct(String productId) async {
    try {
      await _productsRef.doc(productId).delete();
    } catch (e) {
      print('Lỗi khi xóa sản phẩm: $e');
      rethrow; // Ném lại lỗi để UI hoặc caller xử lý
    }
  }
}
