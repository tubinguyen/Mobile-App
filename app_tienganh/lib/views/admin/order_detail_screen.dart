import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/shopping_cart_item_final.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomNavBar(
        title: 'Thông tin đơn hàng',
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Orders').doc(orderId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Không tìm thấy đơn hàng'));
          }

          final orderData = snapshot.data!.data() as Map<String, dynamic>;
          String date = 'N/A';
          if (orderData['createdAt'] != null) {
            if (orderData['createdAt'] is Timestamp) {
              date = (orderData['createdAt'] as Timestamp)
                  .toDate()
                  .toString();
            } else if (orderData['createdAt'] is String) {
              try {
                date = DateTime.parse(orderData['createdAt']).toString();
              } catch (e) {
                date = 'Invalid Date Format';
              }
            } else {
              date = 'Invalid Date Type';
            }
          }
          final String status = orderData['status'] ?? 'Chưa xác định';
          final bool isReceived = status == 'Đã nhận hàng';
          final List<dynamic> products = orderData['products'] ?? [];
          final double totalPrice = (orderData['totalAmount'] ?? 0).toDouble();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 20, color: AppColors.textPrimary),
                    const SizedBox(width: 8),
                    Text(
                      "Ngày đặt: $date",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      isReceived
                          ? Icons.check_circle
                          : Icons.local_shipping_outlined,
                      color: isReceived ? AppColors.green : AppColors.yellow,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Trạng thái: ",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: isReceived ? AppColors.green : AppColors.yellow,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
     
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: AppColors.red),
                    const SizedBox(width: 4),
                    Text(
                      "Tổng: ${totalPrice.toStringAsFixed(0)} VND",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  "Chi tiết đơn hàng",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: AppColors.highlightDarkest,
                  ),
                ),
                const SizedBox(height: 12),

                Column(
                  children: products.map((product) {
                    final String imageName = product['productImage'] ?? '';
                    final double price = (product['price'] ?? 0.0).toDouble();
                    final String title = product['productName'] ?? '';
                    final int quantity = product['quantity'] ?? 0;

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.blueLightest,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ShoppingCartItemFinal(
                        imageName: imageName,
                        price: price,
                        title: title,
                        quantity: quantity,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
              ],
            ),
          );
        },
      ),
    );
  }
}

