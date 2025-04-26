// import 'package:flutter/material.dart';
// import '../core/app_colors.dart';

// class Toggle extends StatefulWidget {
//   final bool isOn; // Biến lưu trạng thái bật/tắt
  
//   const Toggle({required this.isOn, super.key});

//   @override
//   State<Toggle> createState() => _ToggleState();
// }

// class _ToggleState extends State<Toggle> {
//   late bool isOn; // Biến lưu trạng thái bật/tắt
//   String toggleState = "OFF"; // Biến lưu chữ trạng thái

//   void _toggleSwitch() {
//     setState(() {
//       isOn = !isOn;
//       toggleState = isOn ? "ON" : "OFF"; // Cập nhật trạng thái chữ
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _toggleSwitch,
//       child: Column(
//         children: [
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 100),
//             width: 35,
//             height: 20,
//             padding: const EdgeInsets.symmetric(horizontal: 2),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: isOn ? AppColors.highlightDarkest : AppColors.border,
//             ),
//             child: AnimatedAlign(
//               duration: const Duration(milliseconds: 100),
//               alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
//               child: Container(
//                 width: 16,
//                 height: 16,
//                 decoration: const BoxDecoration(
//                   color: AppColors.background,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 5), // Khoảng cách
//           // Text(
//           //   "State: $toggleState", // Hiển thị trạng thái
//           //   style: const TextStyle(fontSize: 12),
//           // ),
//         ],
//       ),
//     );
//   }
// }


// //cách dùng
// // Toggle(),

import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class Toggle extends StatefulWidget {
  final bool isOn; // Trạng thái bật/tắt ban đầu
  final ValueChanged<bool>? onToggle; // Callback khi trạng thái thay đổi

  const Toggle({required this.isOn, this.onToggle, super.key});

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  late bool isOn; // Trạng thái hiện tại của toggle

  @override
  void initState() {
    super.initState();
    isOn = widget.isOn; // Khởi tạo trạng thái từ widget cha
  }

  void _toggleSwitch() {
    setState(() {
      isOn = !isOn; // Đảo trạng thái
    });
    if (widget.onToggle != null) {
      widget.onToggle!(isOn); // Gọi callback nếu được truyền
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 36,
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
    );
  }
}