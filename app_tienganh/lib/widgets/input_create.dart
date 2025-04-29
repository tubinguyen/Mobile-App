import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class InputCreate extends StatelessWidget {
  final String label;
  final String? subtitle;
  final TextEditingController controller;

  const InputCreate({
    super.key,
    required this.label,
    required this.controller,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.highlightDarkest,
            fontFamily: 'Montserrat',
          ),
        ),
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
              width: 372,
              child: TextField(
                controller: controller, //điều khiển textfield
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
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
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
// Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               InputCreate(label: 'Tiêu đề'),
//               SizedBox(height: 16), khoảng cách giữa các ô
//               InputCreate(label: 'Tiêu đề', subtitle: 'Chủ đề, Chương', controller: TextEditingController(),),
//             ],),

