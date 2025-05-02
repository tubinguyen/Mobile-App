import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';

class YourOrder extends StatelessWidget {
  final String text;
  final VoidCallback onTap;  // Chuyển từ Widget destination sang VoidCallback onTap

  const YourOrder({super.key, required this.text, required this.onTap});

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
      // Gọi onTap khi bấm nút
      onPressed: onTap,
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
            SvgPicture.asset(
              'assets/img/ArrowRight.svg',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
