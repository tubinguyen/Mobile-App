import 'package:flutter/material.dart';
import '../core/app_colors.dart';

enum ButtonState { success, failure, premium }

class PremiumButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap; 
  final ButtonState state;
  final Color textColor;

  const PremiumButton({
    super.key,
    required this.text,
    required this.onTap, 
    required this.state,
    required this.textColor,
  });

  Color getBackgroundColor() {
    switch (state) {
      case ButtonState.success:
        return AppColors.green;
      case ButtonState.failure:
        return AppColors.red;
      case ButtonState.premium:
        return AppColors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = onTap == null ? Colors.grey : getBackgroundColor();

    return SizedBox(
      height: 26,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          minimumSize: const Size(0, 26),
        ),
        onPressed: onTap, 
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
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