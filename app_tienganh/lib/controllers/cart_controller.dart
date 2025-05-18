import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_tienganh/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartController {
  final CollectionReference _cartRef =
      FirebaseFirestore.instance.collection('Carts');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addToCart(
    String bookId,
    String bookName,
    String imageUrl,
    int quantity,
    double price,
    BuildContext context,
  ) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đăng nhập để thêm vào giỏ hàng')),
      );
      return;
    }

    try {
      final existingCart =
          await _cartRef.where('userId', isEqualTo: user.uid).get();

      if (existingCart.docs.isNotEmpty) {
        final cartDocRef = _cartRef.doc(existingCart.docs.first.id);
        final existingCartData =
            existingCart.docs.first.data() as Map<String, dynamic>;
        final existingCartModel =
            CartModel.fromMap(existingCartData, existingCart.docs.first.id);

        int existingIndex = existingCartModel.cartItems.indexWhere(
          (item) => item.bookId == bookId,
        );

        List<CartItem> updatedCartItems = [...existingCartModel.cartItems];

        if (existingIndex != -1) {
          updatedCartItems[existingIndex] =
              updatedCartItems[existingIndex].copyWith(
            quantity: updatedCartItems[existingIndex].quantity + quantity,
          );
        } else {
          updatedCartItems.add(CartItem(
            bookId: bookId,
            bookName: bookName,
            imageUrl: imageUrl,
            quantity: quantity,
            price: price,
          ));
        }

        final updatedCart =
            existingCartModel.copyWith(cartItems: updatedCartItems);
        await cartDocRef.update(updatedCart.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã cập nhật giỏ hàng')),
        );
      } else {
        final newCartItem = CartItem(
          bookId: bookId,
          bookName: bookName,
          imageUrl: imageUrl,
          quantity: quantity,
          price: price,
        );

        final newCart = CartModel(
          cartId: '', 
          userId: user.uid,
          cartItems: [newCartItem],
          createdAt: DateTime.now(),
        );

        final newDocRef = await _cartRef.add(newCart.toMap());

        await newDocRef.update({'cartId': newDocRef.id});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã thêm vào giỏ hàng')),
        );
      }
    } catch (e) {
      print('Lỗi khi thêm vào giỏ hàng: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Có lỗi xảy ra, vui lòng thử lại sau')),
      );
    }
  }

  Stream<CartModel?> getCart() {
    final User? user = _auth.currentUser;
    if (user == null) {
      return Stream.value(null);
    }

    return _cartRef.where('userId', isEqualTo: user.uid).snapshots().map(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final cartData = snapshot.docs.first.data() as Map<String, dynamic>;
          return CartModel.fromMap(cartData, snapshot.docs.first.id);
        } else {
          return null;
        }
      },
    );
  }

  Future<void> updateCartItemQuantity(String bookId, int quantity) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      return;
    }

    try {
      final existingCart =
          await _cartRef.where('userId', isEqualTo: user.uid).get();

      if (existingCart.docs.isNotEmpty) {
        final cartDocRef = _cartRef.doc(existingCart.docs.first.id);
        final existingCartData =
            existingCart.docs.first.data() as Map<String, dynamic>;
        final existingCartModel =
            CartModel.fromMap(existingCartData, existingCart.docs.first.id);

        int existingIndex = existingCartModel.cartItems.indexWhere(
          (item) => item.bookId == bookId,
        );

        if (existingIndex != -1) {
          List<CartItem> updatedCartItems = [...existingCartModel.cartItems];
          updatedCartItems[existingIndex] =
              updatedCartItems[existingIndex].copyWith(quantity: quantity);

          final updatedCart =
              existingCartModel.copyWith(cartItems: updatedCartItems);
          await cartDocRef.update(updatedCart.toMap());
        }
      }
    } catch (e) {
      print('Lỗi khi cập nhật số lượng: $e');
    }
  }

  Future<void> removeItemFromCart(String bookId) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      return;
    }

    try {
      final existingCart =
          await _cartRef.where('userId', isEqualTo: user.uid).get();

      if (existingCart.docs.isNotEmpty) {
        final cartDocRef = _cartRef.doc(existingCart.docs.first.id);
        final existingCartData =
            existingCart.docs.first.data() as Map<String, dynamic>;
        final existingCartModel =
            CartModel.fromMap(existingCartData, existingCart.docs.first.id);

        List<CartItem> updatedCartItems = existingCartModel.cartItems
            .where((item) => item.bookId != bookId)
            .toList();

        final updatedCart =
            existingCartModel.copyWith(cartItems: updatedCartItems);
        await cartDocRef.update(updatedCart.toMap());
      }
    } catch (e) {
      print('Lỗi khi xóa sản phẩm: $e');
    }
  }

  Future<void> deleteCart() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      return;
    }
    try {
      final existingCart =
          await _cartRef.where('userId', isEqualTo: user.uid).get();
      if (existingCart.docs.isNotEmpty) {
        final cartDocRef = _cartRef.doc(existingCart.docs.first.id);
        await cartDocRef.delete();
      }
    } catch (e) {
      print("Lỗi xóa giỏ hàng: $e");
    }
  }
}
