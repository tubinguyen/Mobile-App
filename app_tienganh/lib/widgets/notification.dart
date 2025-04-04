import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';

class NotificationCard extends StatelessWidget {
  // Variables to pass data
  final String mainText;
  final String subText;
  final String timeAgo;
  final String svgPath;

  const NotificationCard({
    super.key,
    required this.mainText,
    required this.subText,
    required this.timeAgo,
    required this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainText,
                style: TextStyle(color: AppColors.textPrimary, fontSize: 12,  fontFamily: 'Montserrat',),
              ),
              SizedBox(height: 4),
              Text(
                subText,
                style: TextStyle(color: AppColors.textPrimary, fontSize: 12,  fontFamily: 'Montserrat',),
              ),
            ],
          ),

          SizedBox(width: 40), 
          // Time
          Text(
            timeAgo,
            style: TextStyle(color: AppColors.border, fontSize: 12, fontFamily: 'Montserrat',),
          ),
        ],
      ),
    );
  }
}

// cách sử dụng
// NotificationCard(
//             mainText: 'Cùng trở lại học "vocab toeic week 1".',
//             subText: 'Tiếp tục nào!',
//             timeAgo: '9m',
//             svgPath:
//                 'assets/img/Frame107.svg', // Make sure to add this SVG to your assets
//           ),
