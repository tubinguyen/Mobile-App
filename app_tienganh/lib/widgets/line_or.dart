import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class LineOr extends StatelessWidget {
  const LineOr({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: 1.6,
            indent: 45,
            endIndent: 15,
          ),
        ),
        Text(
          'Hoặc',
          style: TextStyle(
            color: AppColors.border,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: 1.6,
            indent: 15,
            endIndent: 45,
          ),
        ),
      ],
    );
  }
}
// cách sử dụng
//const Center(child: LineOr()),