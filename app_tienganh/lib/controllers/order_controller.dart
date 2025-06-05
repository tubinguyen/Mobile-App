import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/order_model.dart';
import 'package:flutter/material.dart';

class OrderController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Tạo đơn hàng mới
  Future<void> createOrder({
    required String receiverName,
    required String receiverEmail,
    required String receiverPhone,
    required String deliveryAddress,
    required double totalAmount,
    required String paymentMethod,
    required List<OrderItem> cartItems,
    String? orderId,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Người dùng chưa đăng nhập");

    final actualOrderId = orderId ?? const Uuid().v4();
    final userDocRef = _firestore.collection('users').doc(user.uid);

    try {
      final order = OrderModel(
        orderId: actualOrderId,
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

      // Ghi đơn hàng vào Firestore
      await _firestore.collection('Orders').doc(actualOrderId).set(order.toMap());

      // Cập nhật số lượng đơn hàng người dùng
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

  // Cập nhật trạng thái đơn hàng
  Future<void> updateOrderStatus(
    BuildContext context,
    String orderId,
    String newStatus,
  ) async {
    try {
      final orderRef = _firestore.collection('Orders').doc(orderId);
      final orderSnapshot = await orderRef.get();

      if (!orderSnapshot.exists) {
        throw Exception('Không tìm thấy đơn hàng');
      }

      final batch = _firestore.batch();
      batch.update(orderRef, {'status': newStatus});

      // Nếu là "Đã nhận hàng", cập nhật trạng thái thanh toán
      if (newStatus == 'Đã nhận hàng') {
        batch.update(orderRef, {'paymentStatus': 'Thanh toán thành công'});
      }

      // Nếu là "Đã xác nhận", cập nhật lại orderCount cho người dùng
      if (newStatus == 'Đã xác nhận') {
        final userId = orderSnapshot.data()?['userId'];
        if (userId != null) {
          final userRef = _firestore.collection('users').doc(userId);
          final userSnap = await userRef.get();
          if (userSnap.exists) {
            final currentCount = userSnap.data()?['orderCount'] ?? 0;
            batch.update(userRef, {'orderCount': currentCount + 1});
          } else {
            batch.set(userRef, {'orderCount': 1});
          }
        }
      }

      await batch.commit();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã cập nhật trạng thái đơn hàng thành "$newStatus"'),
        ),
      );
    } catch (e) {
      print('Lỗi cập nhật trạng thái đơn hàng: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi khi cập nhật trạng thái')),
      );
    }
  }

  // Cập nhật trạng thái thanh toán riêng
  Future<void> updatePaymentStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection('Orders').doc(orderId).update(
        {'paymentStatus': newStatus},
      );
    } catch (e) {
      print('Lỗi cập nhật trạng thái thanh toán: $e');
      rethrow;
    }
  }
}
