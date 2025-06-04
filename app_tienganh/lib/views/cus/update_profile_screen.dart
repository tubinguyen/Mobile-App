// import 'package:app_tienganh/core/app_colors.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../widgets/account.dart';
// import '../../widgets/text_input.dart';
// import '../../widgets/large_button.dart';
// import '../../widgets/navbar.dart';
// import '../../controllers/profile_controller.dart';
// import 'package:app_tienganh/models/user_model.dart';
// import 'package:app_tienganh/firebase_options.dart';

// class UpdateProfileScreen extends StatefulWidget {

//   final Function(int) onNavigate;
//   final int? userId;

//   const UpdateProfileScreen(
//     {super.key,
//     required this.onNavigate,
//     this.userId,
//     });

//    @override
//     State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }

// class _UpdateProfileScreenState extends State<UpdateProfileScreen>{
//   int selectedIndex = 4;

//   bool _isLoading = false;
//   final LoadProfileController _controller = LoadProfileController();

//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchUser();
//   }

//   Future<void> _fetchUser() async {
//     final result = await _controller.getUserInfo();

//     if (result != null) {
//       setState(() {
//         _usernameController.text = result.username;
//         _emailController.text = result.email;
        

//       });
//     }
//   }

//   //Pop up báo thành công
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SizedBox(
//             width: 250,
//             height: 200,
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset(
//                     'assets/img/Success_Mark.png',
//                     width: 70,
//                     height: 70,
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Cập nhật thông tin thành công',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontFamily: 'Montserrat',
//                     color: AppColors.highlightDarkest,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//           ),
          
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Đóng popup khi nhấn vào "OK"
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

// Future<void> _updateProfile() async {
//   final username = _usernameController.text.trim();
//   final email = _emailController.text.trim();
//   final currentUser = FirebaseAuth.instance.currentUser;

//   if (username.isEmpty || email.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Vui lòng nhập đầy đủ tên và email'),
//         backgroundColor: Colors.red,
//       ),
//     );
//     return;
//   }

//     final userDoc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(currentUser?.uid)
//         .get();

//     final data = userDoc.data();

//     final orderCount = data?['orderCount'] ?? 0;
//     final learningModuleCount = data?['learningModuleCount'] ?? 0;
//   setState(() {
//     _isLoading = true;
//   });

//   try {
//     final user = UserModel(
//       userId: currentUser?.uid ?? '',
//       username: username,
//       email: email,
//       createdAt: DateTime.now(),
//       orderCount: orderCount,
//       learningModuleCount: learningModuleCount,
//       role: 0,
//       avatarUrl: null,
//     );

//     await _controller.updateUserInfo(user);
//     _showSuccessDialog();
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Cập nhật thất bại: $e'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   } finally {
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }

//   @override
// Widget build(BuildContext context) { // chữ context viết thường nha
//   return Scaffold(
//     appBar: CustomNavBar(
//         title: 'Thông tin tài khoản', 
//         leadingIconPath: "assets/img/back.svg",
//          onLeadingPressed: () {
//           widget.onNavigate(4);
//         },
//         ),

//     body: _isLoading
//       ? const Center(child: CircularProgressIndicator()) 
//       :Center(
//         child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(31, 10, 31, 25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center, // 🛠 thêm dòng này để canh giữa
//             children: [
//               //Account
//               Account(profileImage: "assets/img/user.jpg", username: _usernameController.text),

//               const SizedBox(height: 29),

//             Text(
//               'Thông tin người dùng',
//               style: TextStyle(
//                 fontFamily: 'Semibold',
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 20),

//             //Tên
//             TextInput(
//               label: 'Tên',
//               controller: _usernameController,
//             ),

//             const SizedBox(height: 10),

//             //Email
//             TextInput(
//               label: 'Email',
//               controller: _emailController,
//             ),
      
//             const SizedBox(height: 16),

//             //Đổi mật khẩu
//             GestureDetector(
//                 onTap: () {
//                   widget.onNavigate(19); 
//                 },
//                 child: Text(
//                   'Đổi mật khẩu',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),

//             const SizedBox(height: 16),

//             LargeButton(
//               text: 'Cập nhật thông tin', 
//               onTap: () {
//               _updateProfile();
              
//               } )
//           ],
//         ),
//       ),
//     ),
//     )
//   );
// }
// }
import 'dart:io';

import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/controllers/profile_controller.dart';
import 'package:app_tienganh/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/account.dart';
import '../../widgets/large_button.dart';
import '../../widgets/navbar.dart';
import '../../widgets/text_input.dart';
import '../../controllers/edit_image_controller.dart';

class UpdateProfileScreen extends StatefulWidget {
  final Function(int) onNavigate;
  final int? userId;

  const UpdateProfileScreen({
    super.key,
    required this.onNavigate,
    this.userId,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int selectedIndex = 4;
  bool _isLoading = false;

  final LoadProfileController _controller = LoadProfileController();
  final EditProfileController _editProfileController = EditProfileController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  File? _selectedImage;
  String? _avatarUrl; // ✅ Thêm biến để lưu avatar từ DB

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final result = await _controller.getUserInfo();
    if (result != null) {
      setState(() {
        _usernameController.text = result.username;
        _emailController.text = result.email;
        _avatarUrl = result.avatarUrl; // ✅ Lưu URL ảnh từ DB
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 250,
            height: 200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/img/Success_Mark.png',
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Cập nhật thông tin thành công',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      color: AppColors.highlightDarkest,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _updateProfile() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final currentUser = FirebaseAuth.instance.currentUser;

    if (username.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ tên và email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? avatarUrl = _avatarUrl; // giữ avatar cũ nếu không có ảnh mới

      if (_selectedImage != null) {
        avatarUrl =
            await _editProfileController.uploadImageToMyCloud(_selectedImage!);
        if (avatarUrl != null) {
          await _editProfileController.updateImage(currentUser!.uid, avatarUrl);
        }
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.uid)
          .get();
      final data = userDoc.data();

      final orderCount = data?['orderCount'] ?? 0;
      final learningModuleCount = data?['learningModuleCount'] ?? 0;

      final user = UserModel(
        userId: currentUser.uid,
        username: username,
        email: email,
        createdAt: DateTime.now(),
        orderCount: orderCount,
        learningModuleCount: learningModuleCount,
        role: 0,
        avatarUrl: avatarUrl,
      );

      await _controller.updateUserInfo(user);
      _showSuccessDialog();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cập nhật thất bại: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Thông tin tài khoản',
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () {
          widget.onNavigate(4);
        },
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(31, 10, 31, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Account(
                        profileImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : (_avatarUrl != null
                                ? NetworkImage(_avatarUrl!)
                                : null),
                        username: _usernameController.text,
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: _pickImage,
                        child: const Text(
                          'Chọn ảnh đại diện',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Thông tin người dùng',
                        style: TextStyle(
                          fontFamily: 'Semibold',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      TextInput(
                        label: 'Tên',
                        controller: _usernameController,
                      ),

                      const SizedBox(height: 10),

                      TextInput(
                        label: 'Email',
                        controller: _emailController,
                      ),

                      const SizedBox(height: 16),

                      GestureDetector(
                        onTap: () {
                          widget.onNavigate(19);
                        },
                        child: const Text(
                          'Đổi mật khẩu',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      LargeButton(
                        text: 'Cập nhật thông tin',
                        onTap: _updateProfile,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}