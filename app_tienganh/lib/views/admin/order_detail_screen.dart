import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/shopping_cart_item_final.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/navbar.dart';

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
      backgroundColor:  AppColors.background,
      appBar: CustomNavBar(
        title: 'Thông tin đơn hàng',
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20, color: AppColors.textPrimary,),
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
                  isReceived ? Icons.check_circle : Icons.local_shipping_outlined,
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
                  isReceived ? "Đã nhận hàng" : "Chưa nhận hàng",
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
                  style: TextStyle(
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

           Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.blueLightest,  
                  width: 1,  
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: ShoppingCartItemFinal(
                imageName: imageName,
                price: price,
                title: title,
                quantity: quantity,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
