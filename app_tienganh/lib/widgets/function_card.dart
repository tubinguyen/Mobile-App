import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';

class FunctionCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const FunctionCard({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 352,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.highlightLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.highlightDarkest,
              child: Icon(icon, color: AppColors.background, size: 25),
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Cách gọi
// FunctionCard(
//   icon: Icons.book,
//   text: "Học phần",
//   onTap: () => onNavigate(1), // Gọi hàm từ NavigationPage để đổi trang 
// ),
//nhớ khai báo biến onNavigate trong class 
