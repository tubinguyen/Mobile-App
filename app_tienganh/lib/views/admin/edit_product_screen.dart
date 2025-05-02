import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';

class EditProduct extends StatefulWidget {
  final Function(int) onNavigate;
  
  const EditProduct({super.key, required this.onNavigate});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File? _image;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _nameController.text = "Son dưỡng môi Hàn Quốc";
    _priceController.text = "199000";
    _quantityController.text = "50";
    _descriptionController.text = "Son dưỡng môi thiên nhiên, giữ ẩm tốt.";
  }

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    // Giải phóng controller khi không cần nữa
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
      child: _image == null
          ? const Text(
              "Chưa có ảnh nào được chọn",
              style: TextStyle(
                color: AppColors.highlightDarkest,
                fontSize: 16,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                _image!,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
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
      onTap: () {
        final name = _nameController.text;
        final price = _priceController.text;
        final quantity = _quantityController.text;
        final description = _descriptionController.text;

        print('Tên sản phẩm: $name');
        print('Giá sản phẩm: $price');
        print('Số lượng: $quantity');
        print('Mô tả: $description');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cập nhật thông tin thành công!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      },
      stateLoginOrRegister: AuthButtonState.login,
      textColor: AppColors.text,
    );
  }
}
