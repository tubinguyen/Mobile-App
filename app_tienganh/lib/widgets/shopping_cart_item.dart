import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/number_input_field.dart';

class ShoppingCartItem extends StatelessWidget {
  final String imageName;
  final double price;
  final String title;

  const ShoppingCartItem({super.key, required this.imageName, required this.price, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335, // Độ rộng tổng thể
      height: 100, // Độ cao tổng thể
      padding: EdgeInsets.symmetric(horizontal: 10), // Cách lề trái/phải
      child: Row(
        children: [
          // Hình ảnh sản phẩm
          Image.asset(
            imageName, 
            width: 90,
            height: 100,
          ),
          SizedBox(width: 10), // **Cách ảnh với phần text**

          // Phần thông tin sản phẩm
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold, 
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8), // **Tạo khoảng cách giữa tiêu đề và số lượng**

                // **Padding chỉ bọc Row để canh chỉnh lề**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16), // **Cách ảnh 16px**
                      child: NumberInputField(
                        min: 0,
                        max: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16), // **Cách phải 16px**
                      child: Text(
                        '${(price * 1).toStringAsFixed(0)} VND',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: AppColors.textSecondary,
                          fontSize: 12,
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
