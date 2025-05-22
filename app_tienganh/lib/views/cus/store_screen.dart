// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:app_tienganh/widgets/search_bar.dart';
// import 'package:app_tienganh/widgets/filter.dart';
// import 'package:app_tienganh/widgets/small_book.dart';
// import 'package:app_tienganh/models/book_model.dart';

// class StoreScreen extends StatefulWidget {
//   final Function(int) onNavigate;
//   const StoreScreen({super.key, required this.onNavigate});

//   @override
//   State<StoreScreen> createState() => _StoreScreenState();
// }

// class _StoreScreenState extends State<StoreScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchKeyword = '';
//   String? _selectedFilter;

//   @override


//   void resetPage() {
//     setState(() {
//       _selectedFilter = null;
//       _searchController.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final double bookWidth = (screenWidth - 48) / 2;
//     final double spacing = 16;
//     final double contentWidth = bookWidth * 2 + spacing;

//     Stream<QuerySnapshot<Map<String, dynamic>>> _productStream =
//         FirebaseFirestore.instance.collection('Books').snapshots();
        
//     if (_selectedFilter == 'asc') {
//       _productStream = FirebaseFirestore.instance
//           .collection('Books')
//           .orderBy('price', descending: false)
//           .snapshots();
//     } else if (_selectedFilter == 'desc') {
//       _productStream = FirebaseFirestore.instance
//           .collection('Books')
//           .orderBy('price', descending: true)
//           .snapshots();
//     } else {
//       _productStream = FirebaseFirestore.instance
//           .collection('Books')
//           .snapshots();
//     }

//     return Container(
//       padding: const EdgeInsets.only(right: 16.0),
//       child: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 10),
//               SizedBox(
//                 width: contentWidth,
//                 child: CustomSearchBar(
//                    controller: _searchController,
//                       onChanged: (value) {
//                         setState(() {
//                           _searchKeyword = value.trim().toLowerCase();
//                         });
//                       },
//                 ),
//               ),
//               const SizedBox(height: 10),
//                SizedBox(
//                 width: contentWidth,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     FilterWidget(
//                       options: ['Giá tăng dần', 'Giá giảm dần'],
//                       onSelected: (value) {
//                         setState(() {
//                           if (value == 'Giá tăng dần') {
//                             _selectedFilter = 'asc';
//                           } else if (value == 'Giá giảm dần') {
//                             _selectedFilter = 'desc';
//                           } else {
//                             _selectedFilter = null;
//                           }
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.only(left: 16.0),
//                 child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                   stream: _productStream,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return const Text('Đã xảy ra lỗi khi tải dữ liệu');
//                     }

//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     }

//                     if (!snapshot.hasData) {
//                       return const Text('Không có dữ liệu');
//                     }

//                     final List<Book> books = snapshot.data!.docs.map((doc) {
//                       return Book.fromMap(doc.data(), doc.id);
//                     }).toList();

//                     return Wrap(
//                       alignment: WrapAlignment.center,
//                       spacing: spacing,
//                       runSpacing: spacing,
//                       children: books.map((book) {
//                         return SizedBox(
//                           width: bookWidth,
//                           child: BookSmall(
//                             id: book.bookId,
//                             title: book.name,
//                             price: book.price,
//                             imageUrl: book.imageUrl,
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tienganh/widgets/search_bar.dart';
import 'package:app_tienganh/widgets/filter.dart';
import 'package:app_tienganh/widgets/small_book.dart';
import 'package:app_tienganh/models/book_model.dart';

class StoreScreen extends StatefulWidget {
  final Function(int) onNavigate;
  const StoreScreen({super.key, required this.onNavigate});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';
  String? _selectedFilter;

  void resetPage() {
    setState(() {
      _selectedFilter = null;
      _searchController.clear();
      _searchKeyword = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double bookWidth = (screenWidth - 48) / 2;
    final double spacing = 16;
    final double contentWidth = bookWidth * 2 + spacing;

    // Tạo stream cơ bản từ Firestore
    Stream<QuerySnapshot<Map<String, dynamic>>> _productStream;

    if (_selectedFilter == 'asc') {
      _productStream = FirebaseFirestore.instance
          .collection('Books')
          .orderBy('price', descending: false)
          .snapshots();
    } else if (_selectedFilter == 'desc') {
      _productStream = FirebaseFirestore.instance
          .collection('Books')
          .orderBy('price', descending: true)
          .snapshots();
    } else {
      _productStream =
          FirebaseFirestore.instance.collection('Books').snapshots();
    }

    return Container(
      padding: const EdgeInsets.only(right: 16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: contentWidth,
                child: CustomSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchKeyword = value.trim().toLowerCase();
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: contentWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilterWidget(
                      options: ['Giá tăng dần', 'Giá giảm dần'],
                      onSelected: (value) {
                        setState(() {
                          if (value == 'Giá tăng dần') {
                            _selectedFilter = 'asc';
                          } else if (value == 'Giá giảm dần') {
                            _selectedFilter = 'desc';
                          } else {
                            _selectedFilter = null;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _productStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Đã xảy ra lỗi khi tải dữ liệu');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (!snapshot.hasData) {
                      return const Text('Không có dữ liệu');
                    }

                    final List<Book> books = snapshot.data!.docs
                        .map((doc) => Book.fromMap(doc.data(), doc.id))
                        .toList();

                    // Lọc danh sách theo từ khóa tìm kiếm
                    final List<Book> filteredBooks = books.where((book) {
                      return book.name.toLowerCase().contains(_searchKeyword);
                    }).toList();

                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: spacing,
                      runSpacing: spacing,
                      children: filteredBooks.map((book) {
                        return SizedBox(
                          width: bookWidth,
                          child: BookSmall(
                            id: book.bookId,
                            title: book.name,
                            price: book.price,
                            imageUrl: book.imageUrl,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
