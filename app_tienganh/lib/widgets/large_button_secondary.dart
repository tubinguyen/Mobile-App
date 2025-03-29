import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class LargeButtonSecondary extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const LargeButtonSecondary({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, 
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.highlightDarkest, 
          side: BorderSide(color: AppColors.highlightDarkest, width: 1.5), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), 
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.highlightDarkest, 
            fontFamily: 'Montserrat',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
