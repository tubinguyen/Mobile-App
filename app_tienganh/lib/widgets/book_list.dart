import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/book_in_list.dart'; 
import '../core/app_colors.dart';

class BookList extends StatelessWidget {
  final List<BookInList> books = [
    BookInList(
      id: '1',
      title: 'Lập trình Flutter',
      price: 150000,
      imageUrl: 'assets/img/user.jpg',
    ),
    BookInList(
      id: '2',
      title: 'Học Python cơ bản',
      price: 120000,
      imageUrl: 'assets/img/user.jpg',
    ),
    BookInList(
      id: '3',
      title: 'Data Science với Python',
      price: 180000,
      imageUrl: 'assets/img/user.jpg',
    ),
  ];

  BookList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                'Sách phù hợp với bạn',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Hành động khi nhấn vào "Xem thêm"
                },
                child: Text(
                  'Xem thêm',
                  style: TextStyle(
                    color: AppColors.highlightDarkest,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.only(left: 1),
                child: BookInList(
                  id: book.id,
                  title: book.title,
                  price: book.price,
                  imageUrl: book.imageUrl,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
