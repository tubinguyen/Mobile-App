import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/detail_order.dart';
import 'package:app_tienganh/core/app_colors.dart';

class OrderManagement extends StatelessWidget {
  final Function(int) onNavigate;
  const OrderManagement({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    List<OrderDetail> orderDetails = [
      OrderDetail(
        date: '2025-04-27',
        isReceived: false,
        imageName: 'assets/img/user.jpg',
        price: 350000,
        title: 'Sản phẩm A',
        quantity: 2,
        isAdmin : true,
      ),
      OrderDetail(
        date: '2025-04-28',
        isReceived: true,
        imageName: 'assets/img/user.jpg',
        price: 200000,
        title: 'Sản phẩm B',
        quantity: 1,
        isAdmin: true,
      ),
    ];

    int totalOrders = orderDetails.length;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Quản lý đơn hàng",
        onItemTapped: (int value) {
          switch (value) {
            case 1: 
              onNavigate(9);
              break;
            case 2:
              onNavigate(10);
              break;
            case 3:
              onNavigate(11);
              break;
            case 4:
             onNavigate(21);
              break;
                case 6:
             onNavigate(6);
        break;
            default:
              // Xử lý khác nếu có
              break;
          }
        },
      ),
      body: SingleChildScrollView(
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
                      color: AppColors.highlightDarkest
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
            // Hiển thị các đơn hàng
            ...orderDetails,
          ],
        ),
      ),
    );
  }
}
