import 'package:flutter/material.dart';
import '../../widgets/shopping_cart_item_final.dart';

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
             ShoppingCartItemFinal(
              imageName: 'assets/img/user.jpg',
              price: 23000,
              title: 'Sach Toeic',
              quantity: 4,

             )
          ],
        ),
      ),
    );
  }
}
