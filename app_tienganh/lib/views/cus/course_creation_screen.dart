import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';
class CourseCreationScreen extends StatelessWidget {
final Function(int) onNavigate;

  const CourseCreationScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Tạo Học Phần"), 
      body: const Center(
        child: Text(
          'Trang tạo mới 1 học phần',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),

      ),
    );
  }
}
