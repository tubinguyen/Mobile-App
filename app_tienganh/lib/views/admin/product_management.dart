import 'package:flutter/material.dart';

class ProductManagement extends StatelessWidget {
  final Function(int) onNavigate;
  const ProductManagement({super.key,required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Quản lý sản phẩm', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}