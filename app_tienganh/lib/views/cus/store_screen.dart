import 'package:flutter/material.dart';
 
class StoreScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const StoreScreen({super.key,required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Trang cửa hàng', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}