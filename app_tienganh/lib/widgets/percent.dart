import 'package:flutter/material.dart';
import 'dart:math';
import '../core/app_colors.dart';

class CircularProgressIndicatorCustom extends StatelessWidget {
  final double progress; // Giá trị tiến trình (0.0 - 1.0)
  final double size; // Kích thước vòng tròn
  final Color progressColor;
  final Color backgroundColor;
  final TextStyle textStyle;

  const CircularProgressIndicatorCustom({
    super.key,
    required this.progress,
    this.size = 84.0,
    this.progressColor = AppColors.green,
    this.backgroundColor = AppColors.red,
    this.textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.highlightDarkest, fontFamily: 'Montserrat'),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Vòng tròn nền
          SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: _CircularProgressPainter(progress, progressColor, backgroundColor),
            ),
          ),
          // Hiển thị phần trăm ở giữa
          Text("${(progress * 100).toInt()}%", style: textStyle),
        ],
      ),
    );
  }
}

// Custom Painter để vẽ vòng tròn tiến trình
class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;

  _CircularProgressPainter(this.progress, this.progressColor, this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) - 5;
    
    // Vẽ vòng tròn nền
    canvas.drawCircle(center, radius, backgroundPaint);

    // Vẽ vòng tròn tiến trình
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Bắt đầu từ vị trí 12h
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
} 

//Cách gọi CircularProgressIndicatorCustom trong widget khác
// CircularProgressIndicatorCustom(
    //progress: 0.75, // 75% tiến trình
    // size: 84.0,
    //progressColor: AppColors.blue,
    //backgroundColor: AppColors.white,
    //),