import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/shopping_cart_item_final.dart';

class OrderDetailScreen extends StatelessWidget {
  final String date;
  final bool isReceived;
  final String imageName;
  final double price;
  final String title;
  final int quantity;

  const OrderDetailScreen({
    super.key,
    required this.date,
    required this.isReceived,
    required this.imageName,
    required this.price,
    required this.title,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết đơn hàng"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Ngày: $date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Trạng thái: ${isReceived ? 'Đã nhận hàng' : 'Chưa nhận hàng'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Hiển thị chi tiết sản phẩm
            ShoppingCartItemFinal(
              imageName: imageName,
              price: price,
              title: title,
              quantity: quantity,
            ),
            SizedBox(height: 20),
            // Hiển thị tổng tiền
            Text(
              "TỔNG: ${totalPrice.toStringAsFixed(0)} VND",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
