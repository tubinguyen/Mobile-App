import 'package:flutter/material.dart';

class AccountManagement extends StatelessWidget {
  final Function(int) onNavigate;
  const AccountManagement({super.key,required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Quản lý thông tin', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}