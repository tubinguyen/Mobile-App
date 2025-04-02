import 'package:flutter/material.dart';
import '../../widgets/book.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nội dung Trang chủ',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),

            //TEST
            BookSmall(id: '1', title: 'Sach TOEIC', price: '12000', imageUrl: 'assets/img/book.jpg'),
          ],
        ),
      ),
    );
  }
}
