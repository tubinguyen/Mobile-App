import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/search_bar.dart';
import 'package:app_tienganh/widgets/filter.dart';
import 'package:app_tienganh/widgets/small_book.dart';

class StoreScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const StoreScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> books = List.generate(
      6,
      (index) => {
        'id': '$index',
        'title': 'TOEIC',
        'price': 180000.0,
        'imageUrl': 'assets/img/book.png',
      },
    );

    final double bookWidth = (screenWidth - 48) / 2;
    final double spacing = 16;
    final double contentWidth = bookWidth * 2 + spacing;

    return Container(
      padding: const EdgeInsets.only(right: 16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // SearchBar với độ rộng bằng 2 sách + spacing
              SizedBox(
                width: contentWidth,
                child: const CustomSearchBar(),
              ),

              const SizedBox(height: 10),

              // Filter được căn phải trong cùng độ rộng với SearchBar
              SizedBox(
                width: contentWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Filter(
                      options: ['Lọc theo Ngày', 'Lọc theo Tháng', 'Lọc theo Năm'],
                      onSelected: (value) {
                        debugPrint('Đã chọn: $value');
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: spacing,
                  runSpacing: spacing,
                  children: books.map((book) {
                    return SizedBox(
                      width: bookWidth,
                      child: BookSmall(
                        id: book['id'],
                        title: book['title'],
                        price: book['price'],
                        imageUrl: book['imageUrl'],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
