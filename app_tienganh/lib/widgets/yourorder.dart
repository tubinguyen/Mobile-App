import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';

class YourOrder extends StatelessWidget {
  final String text;
  final Widget destination;

  const YourOrder({super.key, required this.text, required this.destination});

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
            // Gán cứng hình ảnh SVG
            SvgPicture.asset(
              'assets/img/ArrowRight.svg', // Hình cố định
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// Cách sử dụng, ví dụ:
//  YourOther(
//                 text: 'Go to Settings',
//                 destination: const DummyPage(),// click để chuyển hướng đến trang này vd: đến trang DummyPage
//               ),
