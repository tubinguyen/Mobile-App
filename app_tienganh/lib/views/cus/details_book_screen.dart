import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/views/cus/cart_screen.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/widgets/number_input_field.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookId;
  const BookDetailScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {

    final mockBooks = {
      '0': {
        'title': 'Tactics for TOEIC Listening and Reading Test',
        'price': '180000',
        'description': 'Sách TOEIC Preparation LC + RC Volume 1, 2 là cuốn sách phù hợp với những bạn ở trình độ cơ bản, có nhu cầu ôn luyện thi để cải thiện kỹ năng Reading và Listening..',
        'imageUrl': 'assets/img/booktest.jpg',
      },
      '1': {
        'title': 'Tactics for TOEIC - Volume 2',
        'price': '180000',
        'description': 'Nâng cao kỹ năng Listening và Reading TOEIC.',
        'imageUrl': 'assets/img/book.png',
      },
      '2': {
        'title': '600 Essential Words for the TOEIC',
        'price': '150000',
        'description': 'Từ vựng TOEIC căn bản dành cho người học.',
        'imageUrl': 'assets/img/book.png',
      },
      '3': {
        'title': 'Economy TOEIC Test LC1000',
        'price': '200000',
        'description': 'Thực hành nghe TOEIC với 10 đề sát đề thi thật.',
        'imageUrl': 'assets/img/book.png',
      },
      '4': {
        'title': 'TOEIC Analyst',
        'price': '170000',
        'description': 'Tài liệu phân tích cấu trúc bài thi TOEIC.',
        'imageUrl': 'assets/img/book.png',
      },
      '5': {
        'title': 'Hackers TOEIC',
        'price': '190000',
        'description': 'Phù hợp cho người muốn đạt 800+ điểm TOEIC.',
        'imageUrl': 'assets/img/book.png',
      },
    };

    final book = mockBooks[bookId];

    return Scaffold(
      appBar: CustomNavBar(
        title: 'Chi tiết sách',
        leadingIconPath: "assets/img/back.svg",
        actionIconPath: "assets/img/store.svg",
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
      ),
      body: book != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    book['imageUrl']!,
                    width: 412,
                    height: 315,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: Text('Không tải được ảnh')),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    book['title']!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: AppColors.highlightDarkest),  
                  ),
                  const SizedBox(height: 15),
                  Text(book['description']!, style: const TextStyle(fontSize: 13, fontFamily: 'Montserrat', color: AppColors.textPrimary),),
                  const SizedBox(height: 15),
                  Text(
                    'Giá: ${book['price']} đ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: AppColors.red,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Số lượng:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          color: AppColors.highlightDarkest,
                        ),
                      ),
                      const SizedBox(width: 10),
                      NumberInputField(),
                    ],
                  ),
                  const SizedBox(height: 15),
                  LoginAndRegisterButton(
                    text: 'Thêm vào giỏ hàng', 
                    onTap: (){
                      
                    }, 
                    stateLoginOrRegister: AuthButtonState.login, 
                    textColor: AppColors.text
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('Không tìm thấy sách', style: TextStyle(fontSize: 18)),
            ),
    );
  }
}
