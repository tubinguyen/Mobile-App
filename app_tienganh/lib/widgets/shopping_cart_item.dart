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
      padding: EdgeInsets.symmetric(vertical: 5.0), // Cách lề trái/phải
      child: Row(
        children: [
          // Hình ảnh sản phẩm
          Image.asset(
            imageName, 
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 90,
                height: 100,
                color: AppColors.highlightLight,
                child: Icon(
                  Icons.broken_image,
                  color: AppColors.highlightDarkest50,
                ),//icon
              );
            },
          ),
          SizedBox(width: 12), // **Cách ảnh với phần text**

          // Phần thông tin sản phẩm
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
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
                  SizedBox(height: 3.0), 

                  // Giá sách
                  Text(
                    '${price.toStringAsFixed(0)} đ',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),

                  // SizedBox(height: 3.0),

                  // **Padding chỉ bọc Row để canh chỉnh lề**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0), // **Cách ảnh 16px**
                        child: NumberInputField(
                          min: 0,
                          max: 50,
                        ),
                      ),
                      SizedBox(width: 36), // **Cách giữa số lượng và giá**

                      // Giá sản phẩm
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0), // **Cách phải 16px**
                        child: Text(
                          '${(price * 1).toStringAsFixed(0)} VND',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
