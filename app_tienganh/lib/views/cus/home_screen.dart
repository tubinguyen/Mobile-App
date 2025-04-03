import 'package:flutter/material.dart';
<<<<<<< HEAD:app_tienganh/lib/views/home_screen.dart
// import '../widgets/google_button.dart';
// import '../widgets/book_list.dart';
// import 'package:app_tienganh/widgets/detail_order.dart';

=======
>>>>>>> af43a9c894144c0c8796cc4bbc99bb0de1d86723:app_tienganh/lib/views/cus/home_screen.dart

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
<<<<<<< HEAD:app_tienganh/lib/views/home_screen.dart
            CustomSearchBar(), // Nếu cần thanh tìm kiếm thì bỏ comment dòng này
            // BookList(),
            // ShoppingCartItemFinal(imageName: 'assets/img/booktest.jpg', price: 15000, title: 'Tiếng Anh cơ bản', quantity: 5 ),
            // OrderDetail(date: '19/5/2004', isReceived: true, imageName: 'assets/img/booktest.jpg', price: 15000, title: 'English', quantity: 5)
=======
>>>>>>> af43a9c894144c0c8796cc4bbc99bb0de1d86723:app_tienganh/lib/views/cus/home_screen.dart
          ],
        ),
      ),
    );
  }
}
