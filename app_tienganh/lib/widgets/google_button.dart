import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class GoogleSignInButton extends StatelessWidget {
   final VoidCallback onTap;

  const GoogleSignInButton(
    {
      super.key, 
      required this.onTap,
    }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 350,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColors.background,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/google_icon.png', 
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Đăng nhập với Google',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}