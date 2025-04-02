import 'package:flutter/material.dart';

class OrderManagement extends StatelessWidget {
  final Function(int) onNavigate;
  const OrderManagement({super.key,required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Quản lý đơn hàng', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}