import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';

class Flashcard extends StatelessWidget {
  final String label;

  const Flashcard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 372,
      height: 449,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.highlightDarkest),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(
                Icons.volume_up,
                color: AppColors.highlightDarkest,
              ),
              onPressed: () {
              },
            ),
          ),
        ],
      ),
    );
  }
}
// cách sử dụng
//const Center(child: Flashcard(label: "intuitive"))