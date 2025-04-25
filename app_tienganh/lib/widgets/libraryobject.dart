import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';

class LibraryObject extends StatelessWidget {
  final int hocphanID;
  final String title;
  final String subtitle;
  final String username;
  final Function (int) onNavigate;

  const LibraryObject({
    super.key,
    required this.hocphanID,
    required this.title,
    required this.subtitle,
    required this.username,
    required this.onNavigate,
  });

  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      onNavigate(hocphanID); // <-- gọi hàm callback kèm theo ID
    },
    child: Container(
      width: 342,
      height: 102,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.highlightDarkest,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset('assets/img/Group 6.svg', width: 25, height: 25),
              SizedBox(width: 8),
              Text(
                username,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 8),
              SvgPicture.asset(
                'assets/img/material-symbols_lock-outline.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}

// cách sử dụng
// LibraryObject(
//             title: title,
//             subtitle: subtitle,
//             username: username,
//           ),
