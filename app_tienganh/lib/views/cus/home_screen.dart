import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/book_list.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trang chủ')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nội dung Trang chủ',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            BookList(), // Gọi BookList đúng cách
          ],
        ),
      ),
    );
  }
}
