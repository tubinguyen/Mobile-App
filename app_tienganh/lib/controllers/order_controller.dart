import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/order_model.dart';

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
  }
}
