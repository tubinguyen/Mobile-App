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
  final List<Map<String, dynamic>> orders = [
    {
      'date': '19/5/2024',
      'isReceived': true,
      'imageName': 'assets/img/booktest.jpg',
      'title': 'IELTS Vocabulary',
      'price': 100000,
      'quantity': 2,
      'isAdmin': false,
    },
    {
      'date': '20/5/2024',
      'isReceived': false,
      'imageName': 'assets/img/booktest.jpg',
      'title': 'TOEIC Practice',
      'price': 80000,
      'quantity': 1,
      'isAdmin': false,
    },
    {
      'date': '21/5/2024',
      'isReceived': true,
      'imageName': 'assets/img/booktest.jpg',
      'title': 'English Grammar',
      'price': 120000,
      'quantity': 3,
      'isAdmin': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Đơn hàng của bạn', 
        leadingIconPath: "assets/img/back.svg",
         onLeadingPressed: () {
          widget.onNavigate(4);
        },
     ),

        body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(10,14,10,0),
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
              isAdmin: order['isAdmin'],
            ),
          );
        },
      ),
    );
  }
}
