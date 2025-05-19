import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/detail_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; 

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
  late Stream<QuerySnapshot> _ordersStream;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _ordersStream = FirebaseFirestore.instance
        .collection('Orders')
        .where('userId', isEqualTo: widget.userId)
        .snapshots();
  }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Bạn chưa có đơn hàng nào.'));
          }

          final orders = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            String formattedDate = 'N/A';
            if (data['createdAt'] != null) {
              if (data['createdAt'] is Timestamp) {
                formattedDate =
                    _dateFormat.format((data['createdAt'] as Timestamp).toDate()); // Format the Timestamp
              } else if (data['createdAt'] is String) {
                try {
                  formattedDate = _dateFormat.format(DateTime.parse(data['createdAt']));
                } catch (e) {
                  formattedDate =
                      'Invalid Date'; 
                }
              } else {
                formattedDate = 'Invalid Date Type';
              }
            }
            return {
              'orderId': doc.id,
              'date': formattedDate,
              'isReceived': data['status'] == 'Đã nhận hàng',
              'imageName': data['products'] != null &&
                      data['products'].isNotEmpty
                  ? data['products'][0]['productImage'] ?? ''
                  : '',
              'title': data['products'] != null &&
                      data['products'].isNotEmpty
                  ? data['products'][0]['productName'] ?? ''
                  : '',
              'price': data['products'] != null &&
                      data['products'].isNotEmpty
                  ? (data['products'][0]['price'] ?? 0.0).toDouble()
                  : 0.0,
              'quantity': data['products'] != null &&
                      data['products'].isNotEmpty
                  ? data['products'][0]['quantity'] ?? 0
                  : 0,
              'isAdmin': false,
            };
          }).toList();

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: OrderDetail(
                  orderId: order['orderId'],
                  date: order['date'],
                  isReceived: order['isReceived'],
                  imageName: order['imageName'],
                  title: order['title'],
                  price: order['price'],
                  quantity: order['quantity'],
                  isAdmin: order['isAdmin'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

