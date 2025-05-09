class CartModel {
  final String cartId;
  final String userId; // Khóa ngoại tham chiếu đến bảng users
  final String bookId; // Khóa ngoại tham chiếu đến sản phẩm
  final int totalQuantity;
  final double totalPrice;
  final DateTime createdAt;

  CartModel({
    required this.cartId,
    required this.userId,
    required this.bookId,
    required this.totalQuantity,
    required this.totalPrice,
    required this.createdAt,
  });

  factory CartModel.fromMap(Map<String, dynamic> map, String cartId) {
    return CartModel(
      cartId: cartId,
      userId: map['userId'] ?? '',
      bookId: map['bookId'] ?? '',
      totalQuantity: map['totalQuantity'] ?? 0,
      totalPrice: map['totalPrice'] ?? 0.0,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()  
          : DateTime.now(),  
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'userId': userId,
      'bookId': bookId,
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  CartModel copyWith({
    String? cartId,
    String? userId,
    String? bookId,
    int? totalQuantity,
    double? totalPrice,
    DateTime? createdAt,
  }) {
    return CartModel(
      cartId: cartId ?? this.cartId,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
