import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter/material.dart';

class ContentSwitcher extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavigate;

  const ContentSwitcher({
    super.key,
    required this.selectedIndex,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 39,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          _buildNavItem(
            text: "Học phần",
            isSelected: selectedIndex == 0,
            onTap: () => onNavigate(0),
          ),
          _divider(),
          _buildNavItem(
            text: "Bài kiểm tra",
            isSelected: selectedIndex == 1,
            onTap: () => onNavigate(1),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 31,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? AppColors.highlightDarkest
                  : AppColors.textSecondary,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 10, color: AppColors.textSecondary);
  }
}
