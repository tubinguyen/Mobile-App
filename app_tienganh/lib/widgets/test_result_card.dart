import 'package:app_tienganh/widgets/percent.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class TestResultCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final DateTime? date;
  final String moduleId;
  final double progress;

  const TestResultCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.date,
    required this.moduleId,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularProgressIndicatorCustom(
          size: 72,
          progress: progress), // <- dùng widget của bạn
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.highlightDarkest,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textPrimary,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 4),
              Text(
                date != null
                    ? "${date!.day}/${date!.month}/${date!.year}"
                    : "",
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
