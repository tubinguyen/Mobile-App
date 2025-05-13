import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AvatarName extends StatelessWidget {
  final String? avatarUrl; // Đường dẫn hình ảnh jpg/png
  final String? username;

  const AvatarName({
    super.key,
    this.avatarUrl,
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   width: 25,
        //   height: 25,
        //   decoration: BoxDecoration(
        //     color: AppColors.background,
        //     borderRadius: BorderRadius.circular(50),
        //     boxShadow: [BoxShadow(color: AppColors.textPrimary)],
        //     image: DecorationImage(
        //       image: AssetImage(profileImage), // ✅ dùng hình ảnh JPG/PNG
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        avatarUrl != null
                    ? ClipOval(
                        child: Image.network(
                          avatarUrl!,
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return SvgPicture.asset(
                              'assets/img/Group 6.svg',
                              width: 25,
                              height: 25,
                            );
                          },
                        ),
                      )
                    : SvgPicture.asset(
                        'assets/img/Group 6.svg',
                        width: 25,
                        height: 25,
                      ),
        SizedBox(width: 8),
        Text(
          username ?? 'Không rõ',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
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
