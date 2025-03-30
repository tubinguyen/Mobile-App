import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const ReviewScreen({super.key,required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Nội dung Trang ôn tập', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}