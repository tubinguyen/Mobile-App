import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/book_in_list.dart'; // Import widget BookInList bạn đã có
import '../core/app_colors.dart';

class BookListPage extends StatelessWidget {
  final List<BookInList> books;

  BookListPage({super.key}) 
      : books = [
          BookInList(
            id: "1",
            title: "Lập trình Flutter từ A-Z",
            price: '199000', // Chỉnh thành số thay vì chuỗi
            imageUrl: "assets/images/flutter_book.png",
          ),
          BookInList(
            id: "2",
            title: "Học Python dễ dàng",
            price: '149000',
            imageUrl: "assets/images/python_book.png",
          ),
          BookInList(
            id: "3",
            title: "JavaScript nâng cao",
            price: "179000",
            imageUrl: "assets/images/javascript_book.png",
          ),
          BookInList(
            id: "4",
            title: "Phát triển Android với Kotlin",
            price: '189000',
            imageUrl: "assets/images/kotlin_book.png",
          ),
          BookInList(
            id: "5",
            title: "Data Science cho người mới",
            price: '159000',
            imageUrl: "assets/images/datascience_book.png",
          ),
          BookInList(
            id: "6",
            title: "Nhập môn AI và Machine Learning",
            price: '209000',
            imageUrl: "assets/images/ai_book.png",
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Sách phù hợp với bạn',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(), // Đẩy "Xem thêm" về góc phải
            GestureDetector(
              onTap: () {
              },
              child: Text(
                'Xem thêm',
                style: TextStyle(
                  color: AppColors.highlightDarkest,
                  fontSize: 12,
                  fontWeight: FontWeight.w600, // Semi-bold
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final book = books[index];
            return BookInList(
              id: book.id,
              title: book.title,
              price: book.price,
              imageUrl: book.imageUrl,
            );
          },
        ),
      ),
    );
  }
}
