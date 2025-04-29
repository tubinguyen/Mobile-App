import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const ProfileScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Nội dung Trang thông tin tài khoản',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
