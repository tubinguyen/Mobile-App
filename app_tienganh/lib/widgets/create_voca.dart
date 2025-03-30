import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CreateVoca extends StatelessWidget {
  final String label;

  const CreateVoca({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.highlightDarkest,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 1),
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
              width: 372, // Set the specific width here
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border, width: 1),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.highlightDarkest,
                      width: 1,
                    ),
                  ),
                  // Remove content padding to keep the input compact
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// cách sử dụng
//  Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CreateVoca(label: 'Từ vựng'),
//                   SizedBox(height: 30), // khoảng cách giữa các ô
//                   CreateVoca(label: 'Giải nghĩa'),
//                 ],
//               ),
