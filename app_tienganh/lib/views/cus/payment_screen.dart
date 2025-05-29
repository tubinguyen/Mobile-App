import 'package:app_tienganh/controllers/payment_VIETQR_controller.dart';
import 'package:app_tienganh/controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/payment.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:uuid/uuid.dart';

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
  final PaymentController _paymentController = PaymentController();

  String _selectedPaymentMethod = 'Thanh toán khi nhận hàng';

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

    final orderItems = await _paymentController.getOrderItemsFromCart();
    if (orderItems == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giỏ hàng trống.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedPaymentMethod == 'Thanh toán qua VietQR') {
      String orderId = Uuid().v4();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => VietqQRScreen(
                totalPrice: widget.totalPrice,
                orderId: orderId,
                onPaymentSuccess: () async {
                  final success = await _paymentController.submitVietQROrder(
                    orderId: orderId,
                    receiverName: _nameController.text,
                    receiverEmail: _emailController.text,
                    receiverPhone: _phoneController.text,
                    deliveryAddress: _addressController.text,
                    totalAmount: widget.totalPrice,
                    orderItems: orderItems,
                  );

                  if (!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lỗi khi xử lý thanh toán.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const StatusScreen(
                            title: 'Thanh toán thành công',
                          ),
                    ),
                  );
                },
                onPaymentFailed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              const StatusScreen(title: 'Thanh toán thất bại'),
                    ),
                  );
                },
              ),
        ),
      );
    } else {
      final success = await _paymentController.submitOrder(
        receiverName: _nameController.text,
        receiverEmail: _emailController.text,
        receiverPhone: _phoneController.text,
        deliveryAddress: _addressController.text,
        totalAmount: widget.totalPrice,
        paymentMethod: _selectedPaymentMethod,
        orderItems: orderItems,
      );

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lỗi khi tạo đơn hàng.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => const StatusScreen(title: 'Thanh toán thành công'),
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
              options: ['Thanh toán khi nhận hàng', 'Thanh toán qua VietQR'],
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

class StatusScreen extends StatelessWidget {
  final String title;

  const StatusScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final bool isSuccess = title.contains('thành công');
    final IconData icon = isSuccess ? Icons.check_circle : Icons.error;
    final Color iconColor = isSuccess ? Colors.green : Colors.red;

    return Scaffold(
      appBar: CustomNavBar(
        title: title,
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 100),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Quay lại trang chủ'),
            ),
          ],
        ),
      ),
    );
  }
}