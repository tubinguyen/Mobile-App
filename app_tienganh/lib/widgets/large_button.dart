import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const LargeButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: SizedBox(
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.highlightDarkest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
              fontFamily: 'Montserrat',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

//Cach su dung
//LargeButton(
  // text: 'On tập',
  // onTap: () {
  //   onNavigate(1); // Gọi hàm từ NavigationPage để đổi trang
  // },
// ),