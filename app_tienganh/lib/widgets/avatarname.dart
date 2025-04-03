import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AvatarName extends StatelessWidget {
  const AvatarName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(color: AppColors.textPrimary)],
          ),
          child: Icon(
            Icons.image,
            color: const Color.fromARGB(255, 161, 220, 248),
            size: 12.5,
          ),
        ),
        SizedBox(width: 8),
        Text(
          'username',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
      // Biểu tượng và username
    );
  }
}
// cách sử dụng
// AvatarName(),