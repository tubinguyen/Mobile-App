class OrderModel {
  final String orderId;
  final String userId; 
  final List<OrderItem> products; 
  final String receiverName;
  final String receiverEmail;
  final String receiverPhone;
  final String deliveryAddress;
  final double totalAmount;
  final String paymentMethod;
  final DateTime createdAt;
  final String paymentStatus;
  final String status;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.products,
    required this.receiverName,
    required this.receiverEmail,
    required this.receiverPhone,
    required this.deliveryAddress,
    required this.totalAmount,
    required this.paymentMethod,
    required this.createdAt,
    this.status = "Chờ xác nhận",
    this.paymentStatus = "Chưa thanh toán",
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String orderId) {
    List<OrderItem> productList = [];
    if (map['products'] != null) {
      productList = (map['products'] as List)
          .map((item) => OrderItem.fromMap(item))
          .toList();
    }

    return OrderModel(
      orderId: orderId,
      userId: map['userId'] ?? '',
      products: productList,
      receiverName: map['receiverName'] ?? '',
      receiverEmail: map['receiverEmail'] ?? '',
      receiverPhone: map['receiverPhone'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      totalAmount: map['totalAmount'] ?? 0.0,
      paymentMethod: map['paymentMethod'] ?? '',
      createdAt: map['createdAt'] != null
        ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()  
        : DateTime.now(),  
      status: map['status'] ?? 'pending',
      paymentStatus: map['paymentStatus'] ?? 'Chưa thanh toán',
    );
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> productListMap =
        products.map((item) => item.toMap()).toList();

    return {
      'orderId': orderId,
      'userId': userId,
      'products': productListMap,
      'receiverName': receiverName,
      'receiverEmail': receiverEmail,
      'receiverPhone': receiverPhone,
      'deliveryAddress': deliveryAddress,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'paymentStatus': paymentStatus,
    };
  }

  OrderModel copyWith({
    String? orderId,
    String? userId,
    List<OrderItem>? products,
    String? receiverName,
    String? receiverEmail,
    String? receiverPhone,
    String? deliveryAddress,
    double? totalAmount,
    String? paymentMethod,
    DateTime? createdAt,
    String? status,
    String? paymentStatus,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      products: products ?? this.products,
      receiverName: receiverName ?? this.receiverName,
      receiverEmail: receiverEmail ?? this.receiverEmail,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;
  final String? productName;
  final String? productImage;
  final String? cartId; 

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
    this.productName,
    this.productImage,
    this.cartId, 
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? 0.0,
      productName: map['productName'],
      productImage: map['productImage'],
      cartId: map['cartId'], 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'productName': productName,
      'productImage': productImage,
      'cartId': cartId,
    };
  }

  OrderItem copyWith({
    String? productId,
    int? quantity,
    double? price,
    String? productName,
    String? productImage,
    String? cartId, 
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      cartId: cartId ?? this.cartId, 
    );
  }
}
