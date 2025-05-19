import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/payment.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/controllers/order_controller.dart';
import 'package:app_tienganh/controllers/cart_controller.dart';
import 'package:app_tienganh/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
class PaymentScreen extends StatefulWidget {
  final double totalPrice;

  const PaymentScreen({super.key, required this.totalPrice});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String _selectedPaymentMethod = 'Thanh toán khi nhận hàng';

  final OrderController _orderController = OrderController();
  final CartController _cartController = CartController();
  final FirebaseAuth _auth = FirebaseAuth.instance; 

  void _submitOrder() async {
    if (_emailController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ thông tin.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final cart = await _cartController.getCart().first;

    if (cart == null || cart.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giỏ hàng trống.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      List<OrderItem> orderItems = cart.cartItems.map((item) {
        return OrderItem(
          productId: item.bookId,
          quantity: item.quantity,
          price: item.price,
          productName: item.bookName,
          productImage: item.imageUrl,
          cartId: null,
        );
      }).toList();

      await _orderController.createOrder(
        receiverName: _nameController.text,
        receiverEmail: _emailController.text,
        receiverPhone: _phoneController.text,
        deliveryAddress: _addressController.text,
        totalAmount: widget.totalPrice,
        paymentMethod: _selectedPaymentMethod,
        cartItems: orderItems,
      );
      await _cartController.deleteCart();
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thanh toán thành công! Cảm ơn bạn đã mua hàng.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi khi tạo đơn hàng: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Thông tin thanh toán',
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              label: 'Email',
              hint: 'Nhập email đã đăng ký',
              controller: _emailController,
              enabled: true,
            ),
            const SizedBox(height: 24),
            TextInput(
              label: 'Họ và tên',
              hint: 'Nhập họ tên đầy đủ',
              controller: _nameController,
              enabled: true,
            ),
            const SizedBox(height: 24),
            TextInput(
              label: 'Số điện thoại',
              hint: 'Nhập số điện thoại',
              controller: _phoneController,
              enabled: true,
            ),
            const SizedBox(height: 24),
            TextInput(
              label: 'Địa chỉ giao hàng',
              hint: 'Nhập địa chỉ giao hàng',
              controller: _addressController,
              enabled: true,
            ),
            const SizedBox(height: 24),
            TextInput(
              label: 'Tổng giá trị đơn hàng',
              controller: TextEditingController(
                text: '${widget.totalPrice.toStringAsFixed(0)} VNĐ',
              ),
              enabled: false,
            ),
            const SizedBox(height: 24),
            Payment(
              label: 'Hình thức thanh toán',
              options: ['Thanh toán khi nhận hàng', 'Thanh toán qua VNPay'],
              onSelected: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 24),
            LoginAndRegisterButton(
              text: 'Thanh toán',
              onTap: _submitOrder,
              stateLoginOrRegister: AuthButtonState.login,
              textColor: AppColors.text,
            ),
          ],
        ),
      ),
    );
  }
}

