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
      'imageName': 'assets/img/vocabulary.jpg',
      'title': 'Từ vựng TOEIC',
      'price': 150000.0,
    },
  ];

  // Tính tổng giá trị giỏ hàng
  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'];
    }
    return total;
  }

  // Function to remove item from cart
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
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: cartItems.length + 1,
                itemBuilder: (context, index) {
                  if (index < cartItems.length) {
                    return ShoppingCartItem(
                      imageName: cartItems[index]['imageName'],
                      title: cartItems[index]['title'],
                      price: cartItems[index]['price'],
                      onRemove: () => removeItem(index),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  'TỔNG:',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: AppColors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                '${totalPrice.toStringAsFixed(0)} VND',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: AppColors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: LoginAndRegisterButton(
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
                          ),
                        ],
                      ),
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1,
                    color: AppColors.blueLightest,
                    height: 24,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
