import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class Line extends StatelessWidget {
  final double width;
  const Line({super.key, this.width = 200});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        child: Divider(
          color: AppColors.border,
          thickness: 1.6,
        ),
      ),
    );
  }
}

// cách sử dụng
//const Center(child: Line()),