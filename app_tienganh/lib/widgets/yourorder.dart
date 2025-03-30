import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class YourOrder extends StatelessWidget {
  final String text;
  final Widget destination;
  final String? imagePath; // Thêm đường dẫn hình ảnh
  final double imageSize; // Kích thước hình ảnh

  const YourOrder({
    super.key,
    required this.text,
    required this.destination,
    this.imagePath, // Đường dẫn hình ảnh là tùy chọn
    this.imageSize = 24.0, // Kích thước mặc định
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 56,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.background,
          side: BorderSide(color: AppColors.highlightDarkest, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.highlightDarkest,
                fontFamily: 'Montserrat',
              ),
            ),
            // Kiểm tra nếu có đường dẫn hình ảnh
            if (imagePath != null)
              Image.asset(
                imagePath!,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.contain,
              ),
            // else
            //   // Nếu không có hình ảnh, sử dụng icon mặc định
            //   Icon(
            //     Icons.arrow_right,
            //     color: AppColors.highlightDarkest,
            //     size: imageSize,
            //   ),
          ],
        ),
      ),
    );
  }
}

// Cách sử dụng, ví dụ:
//  YourOther(
//                 text: 'Go to Settings',
//                 destination: const DummyPage(title: 'Settings Page'),
//                 imagePath:
//                     'assets/images/ArrowRight.png', // Đường dẫn hình ảnh của bạn
//                 imageSize: 20.0,
//               ),
