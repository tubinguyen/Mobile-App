import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/detail_order.dart';
import 'package:app_tienganh/core/app_colors.dart';

class OrderManagement extends StatelessWidget {
  final Function(int) onNavigate;
  const OrderManagement({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu đơn hàng mẫu (ở đây chỉ có một đơn hàng, bạn có thể mở rộng thêm)
    List<OrderDetail> orderDetails = [
      OrderDetail(
        date: '2025-04-27',
        isReceived: false,
        imageName: 'assets/img/user.jpg',
        price: 350000,
        title: 'Sản phẩm A',
        quantity: 2,
      ),
      // Thêm các đơn hàng khác vào danh sách nếu cần
      OrderDetail(
        date: '2025-04-28',
        isReceived: true,
        imageName: 'assets/img/user.jpg',
        price: 200000,
        title: 'Sản phẩm B',
        quantity: 1,
      ),
    ];

    int totalOrders = orderDetails.length;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Quản lý đơn hàng",
        onItemTapped: (value) {
          onNavigate(value);
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
