import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';

class NotificationCard extends StatelessWidget {
  // Variables to pass data
  final String mainText;
  final String subText;
  final String timeAgo;
  final String svgPath;
  final EdgeInsets? margin; // Optional margin parameter
  final bool softWrap;
  final TextOverflow? overflow;

  const NotificationCard({
    super.key,
    required this.mainText,
    required this.subText,
    required this.timeAgo,
    required this.svgPath,
    this.margin, // Make margin optional
    this.softWrap = false,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          margin ??
          EdgeInsets.symmetric(
            horizontal: 12, // Loại bỏ margin ngang
            vertical: 0, // Giảm margin dọc xuống còn 4
          ), // Default margin if not provided
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(svgPath, width: 40, height: 40),
            SizedBox(width: 12),
            Expanded(
              // Wrap column with Expanded to prevent overflow
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainText,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                    ),
                    softWrap: true, // Add text overflow handling
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: 4),
                  Text(
                    subText,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Add text overflow handling
                  ),
                ],
              ),
            ),
            SizedBox(width: 12), // Reduced from 40 to 12
            Text(
              timeAgo,
              style: TextStyle(
                color: AppColors.border,
                fontSize: 12,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage example:
// NotificationCard(
//   mainText: 'Cùng trở lại học "vocab toeic week 1".',
//   subText: 'Tiếp tục nào!',
//   timeAgo: '9m',
//   svgPath: 'assets/img/Frame107.svg', // Make sure to add this SVG to your assets
//   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4), // Optional custom margin
// ),
