import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onAuthTap;

  const Header({
    super.key,
    required this.onHomeTap,
    required this.onNotificationTap,
    required this.onAuthTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      title: GestureDetector(
        onTap: onHomeTap, 
        child: Row(
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 40,
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/img/noti.svg',
                  width: 20,
                  height: 23,
                ),
                onPressed: onNotificationTap, 
              ),
              PopupMenuButton<String>(
                icon: SvgPicture.asset(
                  'assets/img/account.svg',
                  height: 20,
                ),
                color: AppColors.highlightDarkest,
                elevation: 2,
                position: PopupMenuPosition.under,
                onSelected: (value) {
                  if (value == 'login' || value == 'logout') {
                    onAuthTap(); 
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'login',
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: AppColors.background,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'logout',
                    child: Text(
                      'Đăng xuất',
                      style: TextStyle(
                        color: AppColors.background,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
