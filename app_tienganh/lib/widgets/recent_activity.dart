import 'package:app_tienganh/widgets/percent.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/large_button.dart';

class RecentActivity extends StatelessWidget {
  final String title;
  final String status;
  final String className;
  final String note;
  final String buttonText;
  final double percentage;
  final VoidCallback onTap;

  final bool softWrap;
  final TextOverflow? overflow;

  const RecentActivity({
    super.key,
    required this.title,
    required this.status,
    required this.className,
    required this.note,
    required this.buttonText,
    required this.percentage,
    required this.onTap,
    this.softWrap = false,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: 335,
          padding: const EdgeInsets.all(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularProgressIndicatorCustom(
                    progress: percentage / 100,
                    size: 84.0,
                    progressColor: AppColors.highlightDarkest,
                    backgroundColor: AppColors.highlightLight,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.highlightDarkest,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    // Để tránh overflow ngang
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                            fontFamily: 'Montserrat',
                          ),
                          softWrap: softWrap,
                        ),
                        Text(
                          className,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            fontFamily: 'Montserrat',
                          ),
                          softWrap: softWrap,
                        ),
                        Text(
                          note,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                            fontFamily: 'Montserrat',
                          ),
                          softWrap: softWrap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LargeButton(text: buttonText, onTap: onTap),
            ],
          ),
        ),
      ],
    );
  }
}
