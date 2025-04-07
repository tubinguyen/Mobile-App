import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const LoginScreen({super.key,required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('TRang đăng nhập', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}