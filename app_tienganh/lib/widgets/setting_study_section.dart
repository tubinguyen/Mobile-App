import 'package:flutter/material.dart';

class SettingStudySection extends StatefulWidget {
  @override
  _SettingStudySectionState createState() => _SettingStudySectionState();
}

class _SettingStudySectionState extends State<SettingStudySection> {
  void _handleMenuSelection(String value) {
    switch (value) {
      case 'edit':
        print("Sửa học phần"); // Edit study section
        break;
      case 'duplicate':
        print("Tạo bản sao"); // Duplicate study section
        break;
      case 'delete':
        print("Xóa học phần"); // Delete study section
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popup Menu Example"),
        centerTitle: true,
      ),
      body: Center(
        child: PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          onSelected: _handleMenuSelection,
          itemBuilder: (BuildContext context) => [
            _buildMenuItem('edit', Icons.edit, 'Sửa học phần'),
            _buildMenuItem('duplicate', Icons.copy, 'Tạo bản sao'),
            _buildMenuItem('delete', Icons.delete, 'Xóa học phần'),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.more_vert, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  "Tùy chọn",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(String value, IconData icon, String text) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}