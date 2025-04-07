import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(int)? onItemTapped;

  const CustomAppBar({super.key, required this.title, this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.highlightDarkest,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
          color: AppColors.text,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.text),
        onPressed: () => _showMenu(context),
      ),
      actions: [
        PopupMenuButton<int>(
          icon: const Icon(Icons.account_circle, color: AppColors.text),
          color: AppColors.background,
          position: PopupMenuPosition.under,
          onSelected: (value) {
            if (value == 1) {
              _manageAccount();
            } else if (value == 2) {
              _showLogoutDialog(context);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 1,
              child: Text(
                "Tài khoản",
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text(
                "Đăng xuất",
                style: TextStyle(fontFamily: 'Montserrat', color: AppColors.red),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showMenu(BuildContext context) async {
    final value = await showMenu<int>(
      context: context,
      position: const RelativeRect.fromLTRB(10, 70, 100, 0),
      items: [
        const PopupMenuItem<int>(
          value: 7,
          child: Text(
            "Quản lý người dùng",
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
          ),
        ),
        const PopupMenuItem<int>(
          value: 8,
          child: Text(
            "Quản lý sản phẩm",
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
          ),
        ),
        const PopupMenuItem<int>(
          value: 9,
          child: Text(
            "Quản lý đơn hàng",
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
          ),
        ),
      ],
      color: AppColors.background,
    );

    if (context.mounted && value != null && onItemTapped != null) {
      onItemTapped!(value);
    }
  }

  void _manageAccount() {
    if (onItemTapped != null) {
      onItemTapped!(10); 
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        title: const Text(
          "Đăng xuất",
          style: TextStyle(
            color: AppColors.highlightDarkest,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: const Text(
          "Bạn có chắc chắn muốn đăng xuất?",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Hủy",
              style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onItemTapped != null) {
                onItemTapped!(2); 
              }
            },
            child: const Text(
              "Đăng xuất",
              style: TextStyle(color: AppColors.highlightDarkest, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


//Cach su dung
//appBar: CustomAppBar(
      //   title: "Tạo Học Phần",
      //   onItemTapped: (value) {
      //     onNavigate(value);
      //   },
      // ),