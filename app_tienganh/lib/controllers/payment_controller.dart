import 'package:app_tienganh/controllers/cart_controller.dart';
import 'package:app_tienganh/controllers/edit_product.dart';
import 'package:app_tienganh/controllers/order_controller.dart';
import 'package:app_tienganh/models/book_model.dart';
import 'package:app_tienganh/models/order_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentController {
  final OrderController _orderController = OrderController();
  final CartController _cartController = CartController();
  final EditProductController _editProductController = EditProductController();

  Future<bool> updateProductQuantities(List<OrderItem> orderItems) async {
    try {
      for (var item in orderItems) {
        final productData = await _editProductController.getProductData(
          item.productId,
        );
        if (productData == null) {
          print('Sản phẩm ${item.productId} không tồn tại');
          return false;
        }

        final currentQuantity = productData['quantity'] as int? ?? 0;
        final newQuantity = currentQuantity - item.quantity;

        if (newQuantity < 0) {
          print('Số lượng tồn kho không đủ cho sản phẩm ${item.productId}');
          return false;
        }

        final updatedProductData = {
          'name': productData['name'] ?? item.productName,
          'price': productData['price']?.toDouble() ?? item.price,
          'quantity': newQuantity,
          'description': productData['description'] ?? '',
          'imageUrl': productData['imageUrl'] ?? item.productImage,
        };

        Book updatedBook = Book.fromMap(updatedProductData, item.productId);
        final success = await _editProductController.updateProduct(
          item.productId,
          updatedBook,
        );

        if (!success) {
          print('Cập nhật số lượng thất bại cho sản phẩm ${item.productId}');
          return false;
        }
      }
      return true;
    } catch (e) {
      print('Lỗi khi cập nhật số lượng sản phẩm: $e');
      return false;
    }
  }

  Future<List<OrderItem>?> getOrderItemsFromCart() async {
    final cart = await _cartController.getCart().first;
    if (cart == null || cart.cartItems.isEmpty) {
      return null;
    }

    return cart.cartItems.map((item) {
      return OrderItem(
        productId: item.bookId,
        quantity: item.quantity,
        price: item.price,
        productName: item.bookName,
        productImage: item.imageUrl,
        cartId: cart.cartId,
      );
    }).toList();
  }

  Future<bool> submitOrder({
    required String receiverName,
    required String receiverEmail,
    required String receiverPhone,
    required String deliveryAddress,
    required double totalAmount,
    required String paymentMethod,
    required List<OrderItem> orderItems,
  }) async {
    try {
      final updateSuccess = await updateProductQuantities(orderItems);
      if (!updateSuccess) {
        return false;
      }

      await _orderController.createOrder(
        receiverName: receiverName,
        receiverEmail: receiverEmail,
        receiverPhone: receiverPhone,
        deliveryAddress: deliveryAddress,
        totalAmount: totalAmount,
        paymentMethod: paymentMethod,
        cartItems: orderItems,
      );

      await _cartController.deleteCart();
      return true;
    } catch (e) {
      print('Lỗi khi tạo đơn hàng: $e');
      return false;
    }
  }

  Future<bool> submitVietQROrder({
    required String receiverName,
    required String receiverEmail,
    required String receiverPhone,
    required String deliveryAddress,
    required double totalAmount,
    required List<OrderItem> orderItems,
    required String orderId,
  }) async {
    try {
      // Submit order với paymentMethod là VietQR
      await _orderController.createOrder(
        receiverName: receiverName,
        receiverEmail: receiverEmail,
        receiverPhone: receiverPhone,
        deliveryAddress: deliveryAddress,
        totalAmount: totalAmount,
        paymentMethod: 'Thanh toán qua VietQR',
        cartItems: orderItems,
        orderId: orderId,
      );

      // Sử dụng updatePaymentStatus từ OrderController
      print('Updating payment status for order: $orderId');
      await _orderController.updatePaymentStatus(orderId, 'Đã thanh toán');
      await _cartController.deleteCart();
      return true;
    } catch (e) {
      print('Lỗi khi xử lý thanh toán VietQR: $e');
      return false;
    }
  }
}