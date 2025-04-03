import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';
import '../../widgets/plus_button.dart';

class CourseCreationScreen extends StatelessWidget {
final Function(int) onNavigate;
  const CourseCreationScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tạo Học Phần",
        onItemTapped: (value) {
          onNavigate(value);
        },
      ),
      body: Stack(
        children: [
          PlusButton(
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
}