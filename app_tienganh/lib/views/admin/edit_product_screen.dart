import 'package:app_tienganh/controllers/edit_product.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';

class EditProduct extends StatefulWidget {
  final String
  productId; // productId được truyền từ màn hình danh sách sản phẩm
  final Function(int) onNavigate;

  const EditProduct({
    super.key,
    required this.onNavigate,
    required this.productId,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File? _image;
  String? _imagePath; // Lưu URL ảnh từ Firebase hoặc assets
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _descriptionController;
  final EditProductController _controller = EditProductController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _quantityController = TextEditingController();
    _descriptionController = TextEditingController();

    _initializeData();
  }

  // Lấy dữ liệu sản phẩm từ EditProductController
  Future<void> _initializeData() async {
    final productData = await _controller.getProductData(widget.productId);
    if (productData != null) {
      setState(() {
        _nameController.text = productData['name'] ?? '';
        _priceController.text = productData['price']?.toString() ?? '';
        _quantityController.text = productData['quantity']?.toString() ?? '';
        _descriptionController.text = productData['description'] ?? '';
        _imagePath = productData['imagePath']; // Lưu URL hoặc đường dẫn assets
      });
    }
  }

  // Yêu cầu quyền truy cập ảnh
  Future<void> _requestPermissionAndPickImage() async {
    final permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      _pickImage();
    } else {
      final result = await Permission.photos.request();
      if (result.isGranted) {
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
        _imagePath = null; // Xóa URL cũ khi chọn ảnh mới
      });
    }
  }

  // Cập nhật sản phẩm
  Future<void> _updateProduct() async {
    // Tải ảnh lên Firebase Storage nếu có ảnh mới
    final imagePath =
        _image != null
            ? await _controller.uploadImage(_image)
            : _imagePath; // Giữ URL cũ nếu không chọn ảnh mới

    final updatedProductData = {
      'name': _nameController.text,
      'price': int.tryParse(_priceController.text) ?? 0,
      'quantity': int.tryParse(_quantityController.text) ?? 0,
      'description': _descriptionController.text,
      'imagePath': imagePath ?? '', // Nếu không có ảnh thì để trống
    };

    final success = await _controller.updateProduct(
      widget.productId,
      updatedProductData,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cập nhật thông tin thành công!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lỗi khi cập nhật sản phẩm!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
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
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quản lý sản phẩm",
        onItemTapped: widget.onNavigate,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageSection(),
            const SizedBox(height: 20),
            _buildUploadImageButton(),
            const SizedBox(height: 20),
            TextInput(
              label: 'Tên sản phẩm',
              hint: 'Nhập tên sản phẩm',
              controller: _nameController,
              enabled: true,
            ),
            const SizedBox(height: 15),
            TextInput(
              label: 'Giá sản phẩm',
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
              enabled: true,
            ),
            const SizedBox(height: 24),
            _buildUpdateButton(),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Center(
      child:
          _image != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  _image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              )
              : _imagePath != null && _imagePath!.isNotEmpty
              ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _imagePath!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 160,
                      height: 160,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              )
              : const Text(
                "Chưa có ảnh nào được chọn",
                style: TextStyle(
                  color: AppColors.highlightDarkest,
                  fontSize: 16,
                ),
              ),
    );
  }

  Widget _buildUploadImageButton() {
    return GestureDetector(
      onTap: _requestPermissionAndPickImage,
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
    );
  }

  Widget _buildUpdateButton() {
    return LoginAndRegisterButton(
      text: 'Cập nhật thông tin',
      onTap: _updateProduct,
      stateLoginOrRegister: AuthButtonState.login,
      textColor: AppColors.text,
    );
  }
}
