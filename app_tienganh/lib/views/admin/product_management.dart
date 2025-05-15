import 'package:app_tienganh/views/admin/edit_product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/book_inf.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/core/app_colors.dart';

class ProductManagement extends StatefulWidget {
  final Function(int) onNavigate;

  const ProductManagement({super.key, required this.onNavigate});

  @override
  _ProductManagementState createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  late Stream<QuerySnapshot> _productStream;

  @override
  void initState() {
    super.initState();
    // Khởi tạo stream để lắng nghe dữ liệu từ Firestore
    _productStream =
        FirebaseFirestore.instance.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quản lý sản phẩm",
        onItemTapped: (value) {
          widget.onNavigate(value);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _productStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Lỗi khi tải dữ liệu'));
                }

                final products = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: products.length + 1,
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14.0),
                          child: BookInf(
                            name: product['name'],
                            price: product['price'],
                            quantity: product['quantity'],
                            description: product['description'],
                            imagePath:
                                product['imagePath'], // Lấy đường dẫn ảnh từ Firestore
                            onDelete: () {
                              // Xử lý xóa sản phẩm
                              _deleteProduct(product.id);
                            },
                            onEdit: () {
                              // Điều hướng tới trang chỉnh sửa sản phẩm và truyền productId
                              widget.onNavigate(
                                14,
                              ); // Điều hướng đến EditProduct
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => EditProduct(
                                        onNavigate: widget.onNavigate,
                                        productId:
                                            product
                                                .id, // Truyền productId từ Firestore vào EditProduct
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: LoginAndRegisterButton(
                            text: 'Thêm sản phẩm',
                            onTap: () {
                              widget.onNavigate(
                                13,
                              ); // Điều hướng tới trang thêm sản phẩm
                            },
                            stateLoginOrRegister: AuthButtonState.login,
                            textColor: AppColors.text,
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Xóa sản phẩm khỏi Firestore
  Future<void> _deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sản phẩm đã được xóa',
            style: TextStyle(
              color: AppColors.background, // Chỉnh màu chữ
              fontSize: 16, // Chỉnh kích thước chữ
            ),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Lỗi khi xóa sản phẩm',
            style: TextStyle(
              color: AppColors.background, // Chỉnh màu chữ
              fontSize: 16, // Chỉnh kích thước chữ
            ),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
