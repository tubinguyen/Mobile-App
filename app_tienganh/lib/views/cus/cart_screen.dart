import 'package:app_tienganh/views/cus/payment_screen.dart';
 import 'package:flutter/material.dart';
 import 'package:app_tienganh/core/app_colors.dart';
 import 'package:app_tienganh/widgets/navbar.dart';
 import 'package:app_tienganh/widgets/shopping_cart_item.dart';
 import 'package:app_tienganh/widgets/login_and_register_button.dart';
 import 'package:app_tienganh/controllers/cart_controller.dart'; 
 import 'package:app_tienganh/models/cart_model.dart'; 

 class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
 }

class CartScreenState extends State<CartScreen> {
  final CartController _cartController = CartController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Giỏ hàng của bạn',
        leadingIconPath: "assets/img/back.svg",
        actionIconPath: "assets/img/store.svg",
        onLeadingPressed: () => Navigator.pop(context),
        onActionPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()),),
  ),
  body: StreamBuilder<CartModel?>(
    stream: _cartController.getCart(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
        }
      if (snapshot.hasError) {
        return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
        }
      final cart = snapshot.data;
      final cartItems = cart?.cartItems ?? [];

      if (cartItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset(
              'assets/img/empty_cart.png',
              height: 180,
            ),
      const SizedBox(height: 24),
      const Text(
        'Giỏ hàng của bạn đang trống',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.highlightDarkest,
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        'Hãy thêm một vài sản phẩm để bắt đầu nhé!',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: AppColors.highlightDarkest,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 24),
      ],
      ),
      ),
      );
    }

    double totalPrice = cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 16.0, bottom: 100.0),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
        return ShoppingCartItem(
          imageName: item.imageUrl,
          title: item.bookName,
          price: item.price,
          quantity: item.quantity,
          onRemove: () => _cartController.removeItemFromCart(item.bookId),
          onQuantityChanged: (newQuantity) => _cartController.updateCartItemQuantity(item.bookId, newQuantity),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
        color: AppColors.blueLightest,
        height: 24,
      ),
    ),
    );
    },
    ),
    bottomNavigationBar: StreamBuilder<CartModel?>(
      stream: _cartController.getCart(),
      builder: (context, snapshot) {
        final cart = snapshot.data;
        final cartItems = cart?.cartItems ?? [];
        double totalPrice = cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

        return cartItems.isNotEmpty
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
            builder: (context) => PaymentScreen(totalPrice: totalPrice),
            ),
          );
        },
        stateLoginOrRegister: AuthButtonState.login,
        textColor: AppColors.text,
        ),
        ],),)
      : const SizedBox.shrink();
      },
    ),
    );
  }
}