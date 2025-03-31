import 'package:flutter/material.dart';

class CourseCreationScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const CourseCreationScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Trang tạo mới 1 học phần', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}