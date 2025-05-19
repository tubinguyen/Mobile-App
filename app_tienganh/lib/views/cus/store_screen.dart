import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tienganh/widgets/search_bar.dart';
import 'package:app_tienganh/widgets/filter.dart';
import 'package:app_tienganh/widgets/small_book.dart';
import 'package:app_tienganh/models/book_model.dart';

class StoreScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const StoreScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double bookWidth = (screenWidth - 48) / 2;
    final double spacing = 16;
    final double contentWidth = bookWidth * 2 + spacing;

    final Stream<QuerySnapshot<Map<String, dynamic>>> _productStream =
        FirebaseFirestore.instance.collection('Books').snapshots();

    return Container(
      padding: const EdgeInsets.only(right: 16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: contentWidth,
                child: const CustomSearchBar(),
              ),
              const SizedBox(height: 10),
               SizedBox(
                width: contentWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilterWidget(
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
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _productStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Đã xảy ra lỗi khi tải dữ liệu');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (!snapshot.hasData) {
                      return const Text('Không có dữ liệu');
                    }

                    final List<Book> books = snapshot.data!.docs.map((doc) {
                      return Book.fromMap(doc.data(), doc.id);
                    }).toList();

                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: spacing,
                      runSpacing: spacing,
                      children: books.map((book) {
                        return SizedBox(
                          width: bookWidth,
                          child: BookSmall(
                            id: book.bookId,
                            title: book.name,
                            price: book.price,
                            imageUrl: book.imageUrl,
                          ),
                        );
                      }).toList(),
                    );
                  },
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