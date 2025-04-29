import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class LargeButtonSecondary extends StatelessWidget {
  final Color? foregroundColor;
  final Color? borderSideColor;
  final Color? textColor;
  final String text;
  final VoidCallback onTap;

  const LargeButtonSecondary({
    super.key,
    this.foregroundColor = AppColors.highlightDarkest,
    this.borderSideColor,
    this.textColor = AppColors.highlightDarkest,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, 
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor, 
          side: BorderSide(color: borderSideColor ?? AppColors.highlightDarkest, width: 1.5), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), 
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor, 
            fontFamily: 'Montserrat',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
