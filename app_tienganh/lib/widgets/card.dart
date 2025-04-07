import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final String label;

  const Card({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      height: 178,
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
                fontSize: 20,
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
//const Center(child: Card(label: "Text"))