import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/shopping_cart_item_final.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import 'package:app_tienganh/views/admin/order_detail_screen.dart';
import 'package:app_tienganh/controllers/order_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetail extends StatefulWidget {
  final String orderId;
  final String date;
  final bool isReceived;
  final String imageName;
  final double price;
  final String title;
  final int quantity;
  final bool isAdmin;

  const OrderDetail({
    super.key,
    required this.orderId,
    required this.date,
    required this.isReceived,
    required this.imageName,
    required this.price,
    required this.title,
    required this.quantity,
    required this.isAdmin,
  });

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late OrderController _orderController;

  @override
  void initState() {
    super.initState();
    _orderController = OrderController();
  }

  Future<void> _refreshOrderData() async {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Orders').doc(widget.orderId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Lỗi: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('Không tìm thấy đơn hàng');
        }

        final orderData = snapshot.data!.data() as Map<String, dynamic>;
        final String status = orderData['status'] ?? 'Chờ xác nhận'; 
        final String paymentStatus = orderData['paymentStatus'] ?? 'Chưa thanh toán';
        final double totalPrice = (orderData['totalAmount'] ?? 0).toDouble();
        final bool canAdminConfirmOrder = status == 'Chờ xác nhận';
        final bool canAdminMarkDelivered = status == 'Đã xác nhận' || status == 'Chờ giao hàng'; 
        final bool canUserMarkReceived = status == 'Đã giao hàng';

        return SizedBox(
          height: 283,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(color: AppColors.blueLightest, width: 1),
            ),
            elevation: 4,
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 17.0),
                        child: Text(
                          widget.date,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          status,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 19),
                  ShoppingCartItemFinal(
                    imageName: widget.imageName,
                    price: widget.price,
                    title: widget.title,
                    quantity: widget.quantity,
                  ),
                  const Divider(
                      height: 24, thickness: 1, color: AppColors.blueLightest),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "TỔNG: ",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${totalPrice.toStringAsFixed(0)} VND",
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: widget.isAdmin
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PremiumButton(
                                  text: 'Chi tiết',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetailScreen(
                                          orderId: widget.orderId,
                                        ),
                                      ),
                                    );
                                  },
                                  state: ButtonState.premium,
                                  textColor: AppColors.background,
                                ),
                                const SizedBox(width: 8),

                                PremiumButton(
                                  text: 'Xác nhận đơn hàng',
                                  onTap: canAdminConfirmOrder
                                      ? () async {
                                          await _orderController.updateOrderStatus(
                                              context,
                                              widget.orderId,
                                              'Đã xác nhận'); 
                                          _refreshOrderData();
                                        }
                                      : null,
                                  state: ButtonState.premium, 
                                  textColor: AppColors.background,
                                ),
                                const SizedBox(width: 8),

                                PremiumButton(
                                  text: 'Đã giao',
                                  onTap: canAdminMarkDelivered
                                      ? () async {
                                          await _orderController.updateOrderStatus(
                                              context,
                                              widget.orderId,
                                              'Đã giao');
                                          _refreshOrderData();
                                        }
                                      : null,
                                  state: ButtonState.success,
                                  textColor: AppColors.background,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PremiumButton(
                                  text: 'Xem chi tiết',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetailScreen(
                                          orderId: widget.orderId,
                                        ),
                                      ),
                                    );
                                  },
                                  state: ButtonState.premium,
                                  textColor: AppColors.background,
                                ),
                                const SizedBox(width: 8),
                                PremiumButton(
                                  text: 'Đã nhận hàng',
                                  onTap: canUserMarkReceived
                                      ? () async {
                                          await _orderController.updateOrderStatus(
                                              context,
                                              widget.orderId,
                                              'Đã nhận hàng');
                                          _refreshOrderData();
                                        }
                                      : null,
                                  state: ButtonState.success,
                                  textColor: AppColors.background,
                                ),
                              ],
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}