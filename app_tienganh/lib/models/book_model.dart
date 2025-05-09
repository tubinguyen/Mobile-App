class Book {
  final String bookId;
  final String name;
  final double price;
  int quantity;
  final String description;
  final String imageUrl;

  Book({
    required this.bookId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.imageUrl,
  });

  factory Book.fromMap(Map<String, dynamic> map, String documentId) {
    return Book(
      bookId: documentId,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(), 
      quantity: map['quantity'] ?? 0,
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  void increaseQuantity(int amount) {
    if (amount > 0) {
      quantity += amount;
    }
  }

  void decreaseQuantity(int amount) {
    if (amount > 0) {
      quantity -= amount;
      if (quantity < 0) {
        quantity = 0; 
      }
    }
  }

}
