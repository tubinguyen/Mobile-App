import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/views/cus/cart_screen.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/widgets/number_input_field.dart';
import 'package:app_tienganh/controllers/cart_controller.dart';
import 'package:app_tienganh/core/app_colors.dart';

class BookDetailScreen extends StatefulWidget {
  final String bookId;
  const BookDetailScreen({super.key, required this.bookId});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final CartController _cartController = CartController();
  final GlobalKey<NumberInputFieldState> _numberInputFieldKey = GlobalKey<NumberInputFieldState>(); // Add a GlobalKey

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Books').doc(widget.bookId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Không tìm thấy sách'));
          }

          final bookData = snapshot.data!.data() as Map<String, dynamic>;
          final String bookName = bookData['name'] ?? '';
          final String imageUrl = bookData['imageUrl'] ?? '';
          final double price = bookData['price'] ?? 0.0;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    imageUrl,
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
                    bookName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: AppColors.highlightDarkest,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bookData['description'] ?? 'Không có mô tả',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Montserrat',
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Giá: ${price is int ? price : (price as double).toStringAsFixed(0)} đ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: AppColors.red,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Số lượng:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: AppColors.highlightDarkest,
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 120,
                        child: NumberInputField(
                          key: _numberInputFieldKey, 
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  LoginAndRegisterButton(
                    text: 'Thêm vào giỏ hàng',
                    onTap: () {
                      int quantity = _numberInputFieldKey.currentState?.currentValue ?? 1;
                      debugPrint('Quantity: $quantity');
                      if (quantity > 0) {
                        _cartController.addToCart(
                          widget.bookId,
                          bookName,
                          imageUrl,
                          quantity,
                          price,
                          context,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vui lòng nhập số lượng lớn hơn 0')),
                        );
                      }
                    },
                    stateLoginOrRegister: AuthButtonState.login,
                    textColor: AppColors.text,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

