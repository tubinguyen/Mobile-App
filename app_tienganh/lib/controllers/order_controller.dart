import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/order_model.dart';
import 'package:flutter/material.dart';

class OrderController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createOrder({
    required String receiverName,
    required String receiverEmail,
    required String receiverPhone,
    required String deliveryAddress,
    required double totalAmount,
    required String paymentMethod,
    required List<OrderItem> cartItems,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Người dùng chưa đăng nhập");

    final orderId = const Uuid().v4();
    final userDocRef = _firestore.collection('users').doc(user.uid);
    try {
      final order = OrderModel(
        orderId: orderId,
        userId: user.uid,
        products: cartItems,
        receiverName: receiverName,
        receiverEmail: receiverEmail,
        receiverPhone: receiverPhone,
        deliveryAddress: deliveryAddress,
        totalAmount: totalAmount,
        paymentMethod: paymentMethod,
        createdAt: DateTime.now(),
      );

    await _firestore.collection('Orders').doc(orderId).set(order.toMap());

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDocRef);

      if (snapshot.exists) {
        final currentCount = snapshot.data()?['orderCount'] ?? 0;
        transaction.update(userDocRef, {'orderCount': currentCount + 1});
      } else {
        transaction.set(userDocRef, {'orderCount': 1});
      }
    });

  } catch (error) {
    print('Lỗi khi tạo đơn hàng: $error');
    rethrow;
  }
 }

    Future<void> updateOrderStatus(
      BuildContext context, String orderId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('Orders') 
          .doc(orderId)
          .update({'status': newStatus});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã cập nhật trạng thái đơn hàng thành "$newStatus"')),
      );
    } catch (e) {
      print('Lỗi cập nhật trạng thái đơn hàng: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi khi cập nhật trạng thái')),
      );
    }
  }

  
}

