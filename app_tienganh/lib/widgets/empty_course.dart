import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'large_button.dart'; // Import the LargeButton

class EmptyCourse extends StatelessWidget {
  // Customizable properties
  final String title;
  final String subtitle;
  final String buttonText;
  final String imagePath;
  final VoidCallback? onButtonPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const EmptyCourse({
    Key? key,
    this.title = 'Bạn chưa có học phần nào',
    this.subtitle = 'Các học phần bạn tạo sẽ được lưu tại đây',
    this.buttonText = 'Tạo học phần',
    this.imagePath = 'assets/img/book.png', // Default image path
    this.onButtonPressed,
    this.backgroundColor = AppColors.background,
    this.textColor = AppColors.textPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Image.asset(imagePath, width: 100, height: 100, fit: BoxFit.contain),

          SizedBox(height: 16),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8),

          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: const Color.fromRGBO(128, 128, 128, 0.5),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 24),

          // LargeButton
          LargeButton(text: buttonText, onTap: onButtonPressed ?? () {}),
        ],
      ),
    );
  }
}
// cách sử dụng
// EmptyCourse(
// onButtonPressed: () {
//       Code ở đây
//           },
//         ),