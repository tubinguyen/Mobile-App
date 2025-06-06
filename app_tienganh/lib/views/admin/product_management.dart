import 'package:app_tienganh/views/admin/edit_product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/book_inf.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/Controllers/add_delete_product.dart';

class ProductManagement extends StatefulWidget {
  final Function(int) onNavigate;

  const ProductManagement({super.key, required this.onNavigate});

  @override
  _ProductManagementState createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  late Stream<QuerySnapshot> _productStream;
  final ProductController _productController = ProductController();

  @override
  void initState() {
    super.initState();
    _productStream = FirebaseFirestore.instance.collection('Books').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quản lý sản phẩm",
        onItemTapped: (int value) {
          switch (value) {
            case 1: 
              widget.onNavigate(9);
              break;
            case 2:
               widget.onNavigate(10);
              break;
            case 3:
               widget.onNavigate(11);
              break;
            case 6:
              widget.onNavigate(6);
              break;
            default:
              // Xử lý khác nếu có
              break;
          }
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
                final productCount = products.length;

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tổng số sản phẩm: $productCount',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: AppColors.highlightDarkest,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
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
                                  imagePath: product['imageUrl'],
                                  onDelete: () {
                                    _deleteProduct(product.id);
                                  },
                                  onEdit: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => EditProduct(
                                              onNavigate: widget.onNavigate,
                                              productId: product.id,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              // Nút thêm sản phẩm ở cuối danh sách
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14.0,
                                ),
                                child: LoginAndRegisterButton(
                                  text: 'Thêm sản phẩm',
                                  onTap: () {
                                    widget.onNavigate(13);
                                  },
                                  stateLoginOrRegister: AuthButtonState.login,
                                  textColor: AppColors.text,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
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
      await _productController.deleteProduct(productId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sản phẩm đã được xóa',
            style: TextStyle(color: AppColors.background, fontSize: 16),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Lỗi khi xóa sản phẩm: $e',
            style: const TextStyle(color: AppColors.background, fontSize: 16),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
