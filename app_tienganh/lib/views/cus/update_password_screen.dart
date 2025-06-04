import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/large_button.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/account.dart';
import 'package:app_tienganh/controllers/profile_controller.dart';
import 'package:app_tienganh/models/user_model.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final Function(int) onNavigate;
  final int? userId;

  const UpdatePasswordScreen({
    super.key,
    required this.onNavigate,
    this.userId,
  });

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final LoadProfileController _controller = LoadProfileController();

  UserModel? user;
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final result = await _controller.getUserInfo();
    if (result != null) {
      setState(() {
        user = result;
        _emailController.text = user!.email;
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
                  const SizedBox(height: 10),
                  const Text(
                    'Vui lòng kiểm tra email để đổi mật khẩu',
                    style: TextStyle(
                      fontSize: 18,
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
                widget.onNavigate(18); // hoặc số màn hình bạn muốn chuyển đến
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendPasswordResetEmail() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showSuccessDialog();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xảy ra lỗi: $e'),
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
        title: 'Đổi mật khẩu',
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
               profileImage: user!.avatarUrl != null && user!.avatarUrl!.isNotEmpty
              ? NetworkImage(user!.avatarUrl!)
              : AssetImage("assets/img/user.jpg") as ImageProvider,
                username: user!.username,
              ),
                      const SizedBox(height: 10),
                      const Text(
                        'Nhập email để nhận liên kết đặt lại mật khẩu',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontFamily: 'Montserrat',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextInput(
                        label: 'Email',
                        hint: 'Nhập email của bạn',
                      ),
                      const SizedBox(height: 20),
                      LargeButton(
                        text: 'Gửi email đổi mật khẩu',
                        onTap: _sendPasswordResetEmail,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}