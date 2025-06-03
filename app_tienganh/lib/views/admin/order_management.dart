import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/detail_order.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; 

class OrderManagement extends StatefulWidget {
  final Function(int) onNavigate;
  const OrderManagement({super.key, required this.onNavigate});

  @override
  State<OrderManagement> createState() => _OrderManagementState();
}

class _OrderManagementState extends State<OrderManagement> {
  late Stream<QuerySnapshot> _ordersStream;

  @override
  void initState() {
    super.initState();
    _ordersStream = FirebaseFirestore.instance.collection('Orders').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quản lý đơn hàng",
        onItemTapped: (int value) {
           switch (value) {
            case 1: 
              widget.onNavigate(9);
              break;
            case 2:
               widget.onNavigate(10);
              break;
            case 3:
               widget.onNavigate(11);
              break;
            case 6:
              widget.onNavigate(6);
              break;
            default:
              // Xử lý khác nếu có
              break;
          }
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final orderDocs = snapshot.data!.docs;
          final totalOrders = orderDocs.length;
          List<OrderDetail> orderDetailsWidgets = [];

          for (var doc in orderDocs) {
            final data = doc.data() as Map<String, dynamic>;
            final createdAt = data['createdAt'] as String?;
            final orderId = data['orderId'] as String?;
            final products = data['products'] as List<dynamic>?;

            if (products != null && products.isNotEmpty) {
              final firstProduct = products.first as Map<String, dynamic>?;
              final price = firstProduct?['price'] as num?;
              final productName = firstProduct?['productName'] as String?;
              final productImage = firstProduct?['productImage'] as String?;
              final quantity = firstProduct?['quantity'] as num?;
              final status = data['status'] as String?;

              DateTime? parsedDate;
              if (createdAt != null) {
                parsedDate = DateTime.tryParse(createdAt);
              }
              final formattedDate = parsedDate != null
                  ? DateFormat('yyyy-MM-dd').format(parsedDate)
                  : '';

              orderDetailsWidgets.add(
                OrderDetail(
                  orderId: orderId ?? '',
                  date: formattedDate,
                  isReceived: status?.toLowerCase() == '', 
                  imageName: productImage ?? '', 
                  price: price?.toDouble() ?? 0.0,
                  title: productName ?? '',
                  quantity: quantity?.toInt() ?? 0,
                  isAdmin: true,
                ),
              );
            }
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng số đơn hàng:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: AppColors.highlightDarkest,
                        ),
                      ),
                      Text(
                        '$totalOrders',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: AppColors.highlightDarkest,
                        ),
                      ),
                    ],
                  ),
                ),
                ...orderDetailsWidgets,
              ],
            ),
          );
        },
      ),
    );
  }
}