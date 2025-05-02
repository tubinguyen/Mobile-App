import 'package:app_tienganh/views/cus/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/shopping_cart_item.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      'imageName': 'assets/img/starter-toeic.jpg',
      'title': 'Tactics for TOEIC',
      'price': 180000.0,
    },
    {
      'imageName': 'assets/img/starter-toeic.jpg',
      'title': 'Từ vựng TOEIC',
      'price': 150000.0,
    },
  ];

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + item['price']);
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Giỏ hàng của bạn',
        leadingIconPath: "assets/img/back.svg",
        actionIconPath: "assets/img/store.svg",
        onLeadingPressed: () => Navigator.pop(context),
        onActionPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartScreen()),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/empty_cart.png',
                      height: 180,
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Giỏ hàng của bạn đang trống',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.highlightDarkest,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Hãy thêm một vài sản phẩm để bắt đầu nhé!',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: AppColors.highlightDarkest,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 16.0, bottom: 100.0),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return ShoppingCartItem(
                    imageName: cartItems[index]['imageName'],
                    title: cartItems[index]['title'],
                    price: cartItems[index]['price'],
                    onRemove: () => removeItem(index),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  color: AppColors.blueLightest,
                  height: 24,
                ),
              ),
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black12,
                    offset: Offset(0, -1),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TỔNG:',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.red,
                        ),
                      ),
                      Text(
                        '${totalPrice.toStringAsFixed(0)} VND',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LoginAndRegisterButton(
                    text: 'Thanh toán',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentScreen(totalPrice: totalPrice),
                        ),
                      );
                    },
                    stateLoginOrRegister: AuthButtonState.login,
                    textColor: AppColors.text,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
