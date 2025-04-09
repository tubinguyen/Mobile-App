import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AvatarName extends StatelessWidget {
  final String profileImage; // Đường dẫn hình ảnh jpg/png
  final String username;

  const AvatarName({
    super.key,
    required this.profileImage,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(color: AppColors.textPrimary)],
            image: DecorationImage(
              image: AssetImage(profileImage), // ✅ dùng hình ảnh JPG/PNG
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          username,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// cách sử dụng
// AvatarName(
//             profileImage:
//                 'assets/profile.jpg', // Đổi thành đường dẫn ảnh của bạn
//             username: 'Nguyễn Phan Tú Bình',
//           ),
