import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter/material.dart';
// import 'views/test.dart';

class ContentSwitcher extends StatefulWidget {
  final Widget? lessonPage;
  final Widget? testPage;

  const ContentSwitcher({
    super.key,
    this.lessonPage, // Trang đích khi nhấn "Học phần"
    this.testPage, // Trang đích khi nhấn "Bài kiểm tra"
  });

  @override
  State<ContentSwitcher> createState() => _ContentSwitcherState();
}

class _ContentSwitcherState extends State<ContentSwitcher> {
  bool isLessonSelected = true; // Mặc định chọn "Học phần"

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
            isSelected: isLessonSelected,
            onTap: () {
              setState(() {
                isLessonSelected = true;
              });
              // _navigateTo(widget.lessonPage ?? TestPage());
            },
          ),
          _divider(),
          _buildNavItem(
            text: "Bài kiểm tra",
            isSelected: !isLessonSelected,
            onTap: () {
              setState(() {
                isLessonSelected = false;
              });
              // _navigateTo(widget.testPage ?? TestPage());
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

//   void _navigateTo(Widget page) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => page),
//     );
//   }
// }


}
// Cách gọi
//   ContentSwitcher(
//     lessonPage: TestPage(), // Trang "Học phần" của bạn
//     testPage: TestPage(), // Trang "Bài kiểm tra" của bạn
//   ),