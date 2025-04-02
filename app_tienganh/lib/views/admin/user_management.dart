import 'package:flutter/material.dart';

class UserManagement extends StatelessWidget {
  final Function(int) onNavigate;
  const UserManagement({super.key,required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Quản lý người dùng', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}