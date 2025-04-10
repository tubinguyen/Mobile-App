import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter/material.dart';

class ContentSwitcher extends StatefulWidget {
  final Function(int) onNavigate;

  const ContentSwitcher({
    super.key,
    required this.onNavigate, 
  });

  @override
  State<ContentSwitcher> createState() => _ContentSwitcherState();
}

class _ContentSwitcherState extends State<ContentSwitcher> {
  int isLessonSelected = 0; // 0 for lesson, 1 for test 

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
            isSelected: isLessonSelected == 0,
            onTap: () {
              setState(() {
                isLessonSelected = 0;
              });
              widget.onNavigate(1); //dieu huong
             
            },
          ),
          _divider(),
          _buildNavItem(
            text: "Bài kiểm tra",
            isSelected: isLessonSelected == 1,
            onTap: () {
              setState(() {
                isLessonSelected = 1;
              });
              widget.onNavigate(3); //dieu huong
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({required String text, required bool isSelected, required VoidCallback onTap}) {
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
              color: isSelected ? AppColors.highlightDarkest : AppColors.textSecondary,
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
// Cách gọi
//   ContentSwitcher(onNavigate: onNavigate,),