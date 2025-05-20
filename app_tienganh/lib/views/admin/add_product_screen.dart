import 'dart:io';
import 'package:app_tienganh/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/controllers/add_delete_product.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  final Function(int) onNavigate;
  const AddProduct({super.key, required this.onNavigate});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ProductController _productController = ProductController();

  File? _image;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Yêu cầu quyền truy cập ảnh
  Future<void> _requestPermission() async {
    if (await Permission.photos.isGranted) {
      _pickImage();
    } else {
      final status = await Permission.photos.request();
      if (status.isGranted) {
        _pickImage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quyền truy cập ảnh bị từ chối!')),
        );
      }
    }
  }

  // Chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Thêm sản phẩm
  Future<void> _addProduct() async {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin sản phẩm'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Upload ảnh lên cloud riêng, lấy URL trả về
    final imagePath = await _productController.uploadImageToMyCloud(_image);

    // Tạo instance uuid
    var uuid = Uuid();
    // Tạo uuid mới (string)
    String bookId = uuid.v4();

    final book = Book(
      bookId: bookId,
      name: _nameController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      quantity: int.tryParse(_quantityController.text) ?? 0,
      description: _descriptionController.text,
      imageUrl: imagePath ?? '',
    );

    try {
      await _productController.addProduct(book);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sản phẩm đã được thêm thành công!',
            style: TextStyle(color: AppColors.background, fontSize: 16),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      _resetForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Lỗi khi thêm sản phẩm!',
            style: TextStyle(color: AppColors.background, fontSize: 16),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetForm() {
    _nameController.clear();
    _priceController.clear();
    _quantityController.clear();
    _descriptionController.clear();
    setState(() {
      _image = null;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _resetForm();
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Thêm sản phẩm",
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
              case 4:
                widget.onNavigate(21);
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomNavBar(
                  title: "Thêm sản phẩm",
                  leadingIconPath: "assets/img/back.svg",
                  onLeadingPressed: () {
                    _resetForm();
                    widget.onNavigate(10);
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child:
                      _image == null
                          ? const Text(
                            "Chưa có ảnh nào được chọn",
                            style: TextStyle(
                              color: AppColors.highlightDarkest,
                              fontSize: 16,
                            ),
                          )
                          : Image.file(
                            _image!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _requestPermission,
                  child: Text(
                    'Tải ảnh sản phẩm',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: AppColors.highlightDarkest,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.highlightDarkest,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextInput(
                  label: 'Tên sản phẩm',
                  hint: 'Nhập tên sản phẩm',
                  controller: _nameController,
                  enabled: true,
                ),
                const SizedBox(height: 15),
                TextInput(
                  label: 'Gía sản phẩm',
                  hint: 'Nhập giá sản phẩm',
                  controller: _priceController,
                  enabled: true,
                ),
                const SizedBox(height: 15),
                TextInput(
                  label: 'Số lượng sản phẩm',
                  hint: 'Nhập số lượng sản phẩm',
                  controller: _quantityController,
                  enabled: true,
                ),
                const SizedBox(height: 15),
                TextInput(
                  label: 'Mô tả sản phẩm',
                  hint: 'Nhập mô tả sản phẩm',
                  controller: _descriptionController,
                  maxLines: null, // Cho phép nhập nhiều dòng
                  keyboardType: TextInputType.multiline,
                  enabled: true,
                ),
                const SizedBox(height: 24),
                LoginAndRegisterButton(
                  text: 'Thêm sản phẩm',
                  onTap: () {
                    _addProduct();
                  },
                  stateLoginOrRegister: AuthButtonState.login,
                  textColor: AppColors.text,
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    _resetForm();
                    widget.onNavigate(10);
                  },
                  child: const Text(
                    'Quay lại trang trước',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
