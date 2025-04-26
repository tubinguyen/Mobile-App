import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/payment.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/core/app_colors.dart';

class PaymentScreen extends StatelessWidget {
  final double totalPrice;

  const PaymentScreen({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Thông tin thanh toán',
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextInput(
              label: 'Email',
              hint: 'Nhập email đã đăng ký',
              enabled: true,
            ),
            const SizedBox(height: 24),
            const TextInput(
              label: 'Họ và tên',
              hint: 'Nhập họ tên đầy đủ',
              enabled: true,
            ),
            const SizedBox(height: 24),
            const TextInput(
              label: 'Số điện thoại',
              hint: 'Nhập số điện thoại',
              enabled: true,
            ),
            const SizedBox(height: 24),
            const TextInput(
              label: 'Địa chỉ giao hàng',
              hint: 'Nhập địa chỉ giao hàng',
              enabled: true,
            ),
            const SizedBox(height: 24),
            TextInput(
            label: 'Tổng giá trị đơn hàng',
            controller: TextEditingController(text: '${totalPrice.toStringAsFixed(0)} VNĐ'),
            enabled: false,
            ),
            const SizedBox(height: 24),
            Payment(
              label: 'Hình thức thanh toán',
              options: ['Thanh toán khi nhận hàng', 'Thanh toán qua VNPay'],
            ),
            const SizedBox(height: 24),
            LoginAndRegisterButton(
              text: 'Đặt hàng',
              onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thanh toán thành công! Cảm ơn bạn đã mua hàng.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              stateLoginOrRegister: AuthButtonState.login,
              textColor: AppColors.text,
            ),
          ],
        ),
      ),
    );
  }
}
