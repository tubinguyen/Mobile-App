import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/app_colors.dart';

class EmptyNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SVG icon with close mark
        SvgPicture.asset(
          'assets/img/solar_notification-lines-remove-bold-duotone.svg', // Đường dẫn đến file SVG
          width: 83.33, // Điều chỉnh kích thước phù hợp
          height: 83.33,
        ),

        SizedBox(height: 20),

        // Văn bản thông báo
        Text(
          'Bạn không có thông báo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
