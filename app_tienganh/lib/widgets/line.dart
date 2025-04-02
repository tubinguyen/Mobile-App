import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: 1.6,
            indent: 25,
            endIndent: 25,
          ),
        ),
      ],
    );
  }
}
// cách sử dụng
//const Center(child: Line()),