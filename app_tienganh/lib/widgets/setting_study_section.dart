import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class SettingStudySection extends StatelessWidget {
  final Function(String) onSelected;
  const SettingStudySection({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 271,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.highlightLight,
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildMenuItem(Icons.edit, "Sửa học phần"),
          _buildMenuItem(Icons.copy, "Tạo bản sao"),
          _buildMenuItem(Icons.delete, "Xóa học phần"),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return InkWell(
      onTap: () => onSelected(title),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const SizedBox(width: 30, height: 30),
            Icon(icon, color: AppColors.highlightDarkest, size: 30),
            const SizedBox(height: 20, width: 40),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}


//Cach su dung
// SettingStudySection(
  //   onSelected: (title) {
  //     if (title == "Sửa học phần") {
  //       // Xử lý sửa học phần
  //     } else if (title == "Tạo bản sao") {
  //       // Xử lý tạo bản sao
  //     } else if (title == "Xóa học phần") {
  //       // Xử lý xóa học phần
  //     }
  //   },
  // ),