import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../routes/navigation_page.dart';
import '../core/app_colors.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String leadingIconPath;
  final String? actionIconPath;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onActionPressed;

  const CustomNavBar({
    super.key,
    required this.title,
    required this.leadingIconPath,
    this.actionIconPath,
    this.onLeadingPressed,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          leadingIconPath,
          width: 20,
          height: 20,
        ),
        onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        if (actionIconPath != null)
          IconButton(
            icon: SvgPicture.asset(
              actionIconPath!,
              width: 20,
              height: 20,
            ),
            onPressed: onActionPressed ??
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NavigationPage(),
                    ),
                  );
                },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

 //Cach su dung
 //appBar: CustomNavBar(
      //   title: "Thư viện của bạn",
      //   leadingIconPath: "assets/img/back.svg",
      //   actionIconPath: "assets/img/store.svg",
      //   onLeadingPressed: () {
      //     Navigator.pop(context);
      //   },
      //   onActionPressed: () {
      //     onNavigate(3); 
      //   },
      // ),