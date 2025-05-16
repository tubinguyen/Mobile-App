import 'package:app_tienganh/views/cus/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tienganh/widgets/book_in_list.dart';
import '../core/app_colors.dart';

class BookList extends StatelessWidget {
  final Function(int) onNavigate;

  BookList({super.key, required this.onNavigate});

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
                  onNavigate(3);
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
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Hiển thị loading khi đang chờ dữ liệu
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                // Hiển thị khi không có dữ liệu
                return Center(child: Text('Không có sản phẩm nào.'));
              }

              final books = snapshot.data!.docs;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final doc = books[index];
                  final data = doc.data() as Map<String, dynamic>;

                  final id = doc.id; // id từ Firestore
                  final title = data['name'] ?? 'Không có tên';
                  final price = data['price'] ?? 0;
                  final imageUrl = data['imagePath'] ?? 'assets/img/user.jpg';

                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: BookInList(
                      id: id,
                      title: title,
                      price: price,
                      imageUrl: imageUrl,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
