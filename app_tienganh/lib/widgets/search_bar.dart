import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFocused = true;
        });
      },
      child: Container(
        width: 371, // Chiều rộng cố định
        height: 44, // Chiều cao cố định
        margin: const EdgeInsets.only(top: 20, left: 20), // Khoảng cách từ trên và trái
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 11), // Padding bên trong
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Bán kính góc
          border: Border.all(color: AppColors.highlightDarkest, width: 1), // Viền 1px màu xanh
        ),
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm...',
            hintStyle: TextStyle(color: Colors.grey), // Màu chữ của hint
            prefixIcon: Icon(Icons.search, color: Colors.blue), // Biểu tượng search
            border: InputBorder.none, // Xóa viền mặc định
          ),
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            color: _isFocused ? AppColors.textPrimary : AppColors.textSecondary, // Màu chữ thay đổi khi focus
          ),
        ),
      ),
    );
  }
}