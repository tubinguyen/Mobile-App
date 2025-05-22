import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tienganh/models/book_model.dart';

class SearchController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Book>> getFilteredBooks({
    String? priceOrder,      // 'asc' | 'desc' | null
    String? searchKeyword,   // từ khóa tìm kiếm
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection('Books');

    if (priceOrder == 'asc') {
      query = query.orderBy('price', descending: false);
    } else if (priceOrder == 'desc') {
      query = query.orderBy('price', descending: true);
    }

    return query.snapshots().map((snapshot) {
      List<Book> books = snapshot.docs.map((doc) {
        return Book.fromMap(doc.data(), doc.id);
      }).toList();

      if (searchKeyword != null && searchKeyword.isNotEmpty) {
        final keywordLower = searchKeyword.toLowerCase();
        books = books.where((book) {
          return book.name.toLowerCase().contains(keywordLower);
        }).toList();
      }

      return books;
    });
  }
}
