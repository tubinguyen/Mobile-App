import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/book_inf.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/core/app_colors.dart';

class ProductManagement extends StatelessWidget {
  final Function(int) onNavigate;

  const ProductManagement({super.key, required this.onNavigate});

  final List<Map<String, dynamic>> books = const [
    {
      'name': "Check your English Vocabulary for TOEIC",
      'price': 200000,
      'quantity': 10,
      'description': "Sách TOEIC Preparation LC + RC Volume 1, 2",
      'imagePath': 'assets/img/book.jpg', 
    },
    {
      'name': "600 Essential Words for the TOEIC Test",
      'price': 180000,
      'quantity': 15,
      'description': "Cuốn sách giúp cải thiện từ vựng cho kỳ thi TOEIC",
      'imagePath': 'assets/img/book.jpg',
    },
    {
      'name': "Barron's TOEIC with MP3",
      'price': 250000,
      'quantity': 5,
      'description': "Bộ sách luyện thi TOEIC kèm file nghe MP3",
      'imagePath': 'assets/img/book.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quản lý sản phẩm",
        onItemTapped: (value) {
          onNavigate(value);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tổng số sản phẩm: ${books.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: AppColors.highlightDarkest,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: books.length + 1,
                itemBuilder: (context, index) {
                  if (index < books.length) {
                    final book = books[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: BookInf(
                        name: book['name'],
                        price: book['price'],
                        quantity: book['quantity'],
                        description: book['description'],
                        imagePath: book['imagePath'], // truyền imagePath vô đây
                        onDelete: () {
                          // Xử lý xóa sản phẩm
                        },
                        onEdit: () {
                          onNavigate(14);
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: LoginAndRegisterButton(
                        text: 'Thêm sản phẩm',
                        onTap: () {
                          onNavigate(13); // chuyển đến màn thêm sản phẩm
                        },
                        stateLoginOrRegister: AuthButtonState.login,
                        textColor: AppColors.text,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
