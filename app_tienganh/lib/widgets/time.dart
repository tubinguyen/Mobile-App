import 'dart:async';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  bool isExtraTimeAdded = false; // Trạng thái đổi màu
  Duration time = const Duration(seconds: 0); // Bắt đầu từ 0 giây
  late Timer timer; // Timer để chạy thời gian

  @override
  void initState() {
    super.initState();
    // Bắt đầu chạy thời gian
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      setState(() {
        time += const Duration(milliseconds: 100);
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Hủy timer khi widget bị remove
    super.dispose();
  }

  void _addExtraTime() {
    setState(() {
      isExtraTimeAdded = true; // Đổi màu chữ
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        "${time.inMinutes}:${(time.inSeconds % 60).toString().padLeft(2, '0')},${(time.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0')}";

    return GestureDetector(
      onTap: _addExtraTime, // Bấm để đổi màu chữ
      child: Row(
        children: [
          Icon(Icons.access_time, color: AppColors.highlightDarkest, size: 20),
          const SizedBox(width: 8),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: isExtraTimeAdded ? AppColors.red : AppColors.highlightDarkest,
            ),
          ),
        ],
      ),
    );
  }
}

//cách dùng
// Time(),