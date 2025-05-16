import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class EditProductController {
  // Lấy dữ liệu sản phẩm từ Firestore
  Future<Map<String, dynamic>?> getProductData(String productId) async {
    try {
      DocumentSnapshot productSnapshot =
          await FirebaseFirestore.instance
              .collection('products')
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

  // Lưu ảnh vào Firebase Storage và trả về URL
  Future<String?> uploadImage(File? image) async {
    try {
      if (image != null) {
        final storageRef = FirebaseStorage.instance.ref().child(
          'product_images/${DateTime.now().millisecondsSinceEpoch}',
        );
        final uploadTask = storageRef.putFile(image);
        final snapshot = await uploadTask.whenComplete(() {});
        final imagePath = await snapshot.ref.getDownloadURL();
        return imagePath;
      }
    } catch (e) {
      print("Lỗi khi tải ảnh lên Firebase: $e");
    }
    return null;
  }

  // Cập nhật sản phẩm trong Firestore
  Future<bool> updateProduct(
    String productId,
    Map<String, dynamic> productData,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update(productData);
      return true;
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }
}
