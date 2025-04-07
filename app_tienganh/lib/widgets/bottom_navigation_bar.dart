import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  static const List<String> icons = [
    'assets/img/home.svg',
    'assets/img/review_course.svg',
    'assets/img/create_course.svg',
    'assets/img/store.svg',
    'assets/img/account.svg',
  ];

  static const List<String> labels = [
    'Trang chủ',
    'Ôn tập',
    'Tạo mới',
    'Cửa hàng',
    'Tài khoản',
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, 
          selectedItemColor: AppColors.highlightDarkest,
          unselectedItemColor: AppColors.border,
          selectedLabelStyle: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.highlightDarkest, 
        unselectedItemColor: AppColors.border,
        items: List.generate(icons.length, (index) {
          final isSelected = index == selectedIndex;
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              icons[index],
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.highlightDarkest : AppColors.border,
                BlendMode.srcIn,
              ),
            ),
            label: labels[index],
          );
        }),
      ),
    );
  }
}
