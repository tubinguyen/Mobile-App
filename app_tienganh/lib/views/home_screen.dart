import 'package:app_tienganh/widgets/search_bar.dart';
import 'package:flutter/material.dart';
// import '../widgets/google_button.dart';
import '../widgets/book_list.dart';

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
            BookListPage(), // Không cần truyền `books` nữa
          ],
        ),
      ),
    );
  }
}
