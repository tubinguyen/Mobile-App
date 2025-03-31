import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

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
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: AppColors.text),
          onPressed: () => _showMenu(context),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle, color: AppColors.text),
          onPressed: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  void _showMenu(BuildContext context) {
    final RenderBox appBar = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    
    final Offset position = appBar.localToGlobal(Offset.zero, ancestor: overlay);
    final RelativeRect rect = RelativeRect.fromLTRB(
      position.dx + 10, 
      position.dy + appBar.size.height,
      position.dx + appBar.size.width - 10,
      position.dy + appBar.size.height + 50,
    );

    showMenu(
      context: context,
      position: rect,
      items: [
        const PopupMenuItem<int>(
          value: 1,
          child: Text("Quản lý người dùng"),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text("Quản lý sản phẩm"),
        ),
        const PopupMenuItem<int>(
          value: 3,
          child: Text("Quản lý đơn hàng"),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _handleMenuSelection(value, context);
      }
    });
  }

  void _handleMenuSelection(int value, BuildContext context) {
    switch (value) {
      case 1:
        Navigator.pushNamed(context, '/home'); // Điều hướng đến trang chủ
        break;
      case 2:
        Navigator.pushNamed(context, '/settings'); // Điều hướng đến cài đặt
        break;
      case 3:
        _showHelpDialog(context); // Hiển thị hộp thoại trợ giúp
        break;
    }
  }


  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Trợ giúp"),
        content: const Text("Thông tin trợ giúp về ứng dụng."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Đóng"),
          ),
        ],
      ),
    );
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
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Đăng xuất",
              style: TextStyle(
                color: AppColors.highlightDarkest,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
