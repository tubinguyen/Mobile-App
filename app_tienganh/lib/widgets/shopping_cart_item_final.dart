import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ShoppingCartItemFinal extends StatelessWidget {
  final String imageName;
  final double price;
  final String title;
  final int quantity;

  const ShoppingCartItemFinal({
    super.key,
    required this.imageName,
    required this.price,
    required this.title,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = price * quantity;

    return Container(
      width: 335,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          // Image Section
          Image.asset(
            imageName,
            width: 90,
            height: 100,
          ),
          const SizedBox(width: 10),

          // Title & Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                Padding (
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                ),

                const SizedBox(height: 15.0),

                // Quantity and Price Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 17.0), // Cách ảnh 16px
                      child: Text(
                        'Số lượng: $quantity',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16), // Cách phải 16px
                      child: Text(
                        '${totalPrice.toStringAsFixed(0)} VND',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
