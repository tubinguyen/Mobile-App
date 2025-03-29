import 'package:flutter/material.dart';
import '../core/app_colors.dart';

enum AuthButtonState { login, register }

class LoginAndRegisterButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final AuthButtonState stateLoginOrRegister; 
  final Color textColor;

  const LoginAndRegisterButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.stateLoginOrRegister,
    required this.textColor,
  });

  Color getBackgroundColor() {
    switch (stateLoginOrRegister) {
      case AuthButtonState.login:
        return AppColors.highlightDarkest;
      case AuthButtonState.register:
        return AppColors.background;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: getBackgroundColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: stateLoginOrRegister == AuthButtonState.register
                ? BorderSide(color: AppColors.textPrimary, width: 1) 
                : BorderSide.none, 
          ),
          minimumSize: const Size(0, 56),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
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
