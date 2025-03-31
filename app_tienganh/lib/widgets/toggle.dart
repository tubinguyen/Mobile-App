import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class Toggle extends StatefulWidget {
  const Toggle({super.key});

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  bool isOn = false; // Biến lưu trạng thái bật/tắt
  String toggleState = "OFF"; // Biến lưu chữ trạng thái

  void _toggleSwitch() {
    setState(() {
      isOn = !isOn;
      toggleState = isOn ? "ON" : "OFF"; // Cập nhật trạng thái chữ
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 35,
            height: 20,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isOn ? AppColors.highlightDarkest : AppColors.border,
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 100),
              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5), // Khoảng cách
          // Text(
          //   "State: $toggleState", // Hiển thị trạng thái
          //   style: const TextStyle(fontSize: 12),
          // ),
        ],
      ),
    );
  }
}


//cách dùng
// Toggle(),