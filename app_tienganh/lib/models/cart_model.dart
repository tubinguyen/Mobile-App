import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String cartId;
  final String userId;
  final List<CartItem> cartItems;
  final DateTime createdAt;

  CartModel({
    required this.cartId,
    required this.userId,
    required this.cartItems,
    required this.createdAt,
  });

  factory CartModel.fromMap(Map<String, dynamic> map, String cartId) {
    final List<CartItem> cartItems = (map['cartItems'] as List<dynamic>? ?? [])
        .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
        .toList();

    return CartModel(
      cartId: cartId,
      userId: map['userId'] ?? '',
      cartItems: cartItems,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'cartItems': cartItems.map((item) => item.toMap()).toList(),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  CartModel copyWith({
    String? cartId,
    String? userId,
    List<CartItem>? cartItems,
    DateTime? createdAt,
  }) {
    return CartModel(
      cartId: cartId ?? this.cartId,
      userId: userId ?? this.userId,
      cartItems: cartItems ?? this.cartItems,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CartItem {
  final String bookId;
  final String bookName;
  final String imageUrl;
  final int quantity;
  final double price;

  CartItem({
    required this.bookId,
    required this.bookName,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      bookId: map['bookId'] ?? '',
      bookName: map['bookName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'bookName': bookName,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
    };
  }

  CartItem copyWith({
    String? bookId,
    String? bookName,
    String? imageUrl,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      bookId: bookId ?? this.bookId,
      bookName: bookName ?? this.bookName,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
