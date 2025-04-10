import 'package:app_tienganh/widgets/percent.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class TestResultCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;

  const TestResultCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularProgressIndicatorCustom(
          progress: progress), // <- dùng widget của bạn
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.highlightDarkest,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textPrimary,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
