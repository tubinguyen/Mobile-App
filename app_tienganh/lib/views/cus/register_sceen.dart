import 'package:flutter/material.dart';

class RegisterSceen extends StatelessWidget {
  final Function(int) onNavigate;
  const RegisterSceen({super.key,required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Trang đăng ký', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}