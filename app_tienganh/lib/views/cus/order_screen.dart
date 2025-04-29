import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/detail_order.dart';

class OrderScreen extends StatefulWidget {
  final Function(int) onNavigate;
  final int? userId;

  const OrderScreen({
    super.key,
    required this.onNavigate,
    this.userId,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // final String date = '19/5/2024';
  // final bool isReceived = true;
  // final String imageName = 'assets/img/booktest.jpg';
  // final String title = 'IELTS Vocabulary' ;
  // final double price = 100000 ;
  // final int quantity = 2;

   // Tạo danh sách đơn hàng
  final List<Map<String, dynamic>> orders = [
    {
      'date': '19/5/2024',
      'isReceived': true,
      'imageName': 'assets/img/booktest.jpg',
      'title': 'IELTS Vocabulary',
      'price': 100000,
      'quantity': 2,
    },
    {
      'date': '20/5/2024',
      'isReceived': false,
      'imageName': 'assets/img/booktest.jpg',
      'title': 'TOEIC Practice',
      'price': 80000,
      'quantity': 1,
    },
    {
      'date': '21/5/2024',
      'isReceived': true,
      'imageName': 'assets/img/booktest.jpg',
      'title': 'English Grammar',
      'price': 120000,
      'quantity': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Đơn hàng của bạn', 
        leadingIconPath: "assets/img/back.svg",
        actionIconPath: '',
         onLeadingPressed: () {
             widget.onNavigate(4);
              },
              onActionPressed: () {
                widget.onNavigate(4);
              },
        ),

        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: OrderDetail(
              date: order['date'],
              isReceived: order['isReceived'],
              imageName: order['imageName'],
              title: order['title'],
              price: order['price'].toDouble(),
              quantity: order['quantity'],
            ),
          );
        },
      ),
    );
  }
}
