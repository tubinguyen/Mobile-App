import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/search_bar.dart';
// import 'package:app_tienganh/widgets/shopping_cart_item_final.dart';
// import 'package:app_tienganh/widgets/detail_order.dart';

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
            CustomSearchBar(), // Nếu cần thanh tìm kiếm thì bỏ comment dòng này
            // BookList(),
            // ShoppingCartItemFinal(imageName: 'assets/img/booktest.jpg', price: 15000, title: 'Tiếng Anh cơ bản', quantity: 5 ),
            // OrderDetail(date: '19/5/2004', isReceived: true, imageName: 'assets/img/booktest.jpg', price: 15000, title: 'English', quantity: 5)
          ],
        ),
      ),
    );
  }
}
