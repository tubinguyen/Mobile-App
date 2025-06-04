import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/controllers/auth_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(int)? onItemTapped;

  static const int manageUsers = 1;
  static const int manageProducts = 2;
  static const int manageOrders = 3;
  static const int logout = 5;
  static const int accountScreen = 6;

  final AuthService _auth = AuthService();

  CustomAppBar({
    super.key,
    required this.title,
    this.onItemTapped,
  });

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
        tooltip: 'Mở menu',
        onPressed: () => _showMenu(context),
      ),
      actions: [
        PopupMenuButton<int>(
          icon: const Icon(Icons.account_circle, color: AppColors.text),
          color: AppColors.background,
          position: PopupMenuPosition.under,
          onSelected: (value) {
           if (value == logout) {
              _showLogoutDialog(context);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: logout,
              child: Text(
                "Đăng xuất",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: AppColors.red,
                ),
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
          value: manageUsers,
          child: Text(
            "Quản lý người dùng",
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
          ),
        ),
        const PopupMenuItem<int>(
          value: manageProducts,
          child: Text(
            "Quản lý sản phẩm",
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
          ),
        ),
        const PopupMenuItem<int>(
          value: manageOrders,
          child: Text(
            "Quản lý đơn hàng",
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
          ),
        ),
      ],
      color: AppColors.background,
    );

    if (context.mounted && value != null) {
      onItemTapped?.call(value);
    }
  }

  void _manageAccount() {
    onItemTapped?.call(accountScreen);
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
              style: TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              logoutUser(context);
            },
            child: const Text(
              "Đăng xuất",
              style: TextStyle(
                color: AppColors.highlightDarkest,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logoutUser(BuildContext context) async {
    String result = await _auth.signOut();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );

      if (result == "Đăng xuất thành công!") {
        if (onItemTapped != null) {
          onItemTapped!(6); 
        }
      } else {
        // Nếu có lỗi xảy ra, hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
