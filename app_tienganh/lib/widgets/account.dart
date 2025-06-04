// import 'package:flutter/material.dart';
// import '../core/app_colors.dart';

// class Account extends StatelessWidget {
//   final String profileImage;
//   final String username;

//   const Account({ super.key, required this.profileImage, required this.username});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // Avatar tròn
//         CircleAvatar(radius: 50, backgroundImage: AssetImage(profileImage)),
//         SizedBox(height: 12),
//         // Tên người dùng
//         Text(
//           username,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Montserrat',
//             color: AppColors.highlightDarkest,
//           ),
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }
// }
// // cách sử dụng
// // Account(
// //             profileImage:
// //                 'assets/profile.jpg', // Đổi thành đường dẫn ảnh của bạn
// //             username: 'Nguyễn Phan Tú Bình',
// //           ),
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class Account extends StatelessWidget {
  final ImageProvider? profileImage; // nhận ImageProvider thay vì String
  final String username;

  const Account({super.key, this.profileImage, required this.username});

  @override
 Widget build(BuildContext context) {
  return Column(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        backgroundImage: profileImage,
        child: profileImage == null
            ? const Icon(Icons.person, size: 50, color: Colors.grey)
            : null,
      ),
      const SizedBox(height: 10),
      Text(
        username,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'Montserrat',
          color: AppColors.highlightDarkest,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

}