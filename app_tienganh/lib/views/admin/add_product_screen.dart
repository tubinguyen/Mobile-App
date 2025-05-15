import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';

class AddProduct extends StatefulWidget {
  final Function(int) onNavigate;
  const AddProduct({super.key, required this.onNavigate});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
        print('helo ba :' + _image.toString());
      });
    }
  }

  // Lưu ảnh vào Firebase Storage và trả về URL
  Future<String?> _uploadImage() async {
    try {
      print('helo ảnh trong upLoad:' + _image.toString());
      if (_image != null) {
        final storageRef = FirebaseStorage.instance.ref().child(
          'product_images/${DateTime.now().millisecondsSinceEpoch}',
        );
        final uploadTask = storageRef.putFile(_image!);
        final snapshot = await uploadTask.whenComplete(() {});
        final imagePath = await snapshot.ref.getDownloadURL();
        return "assets/img/starter-toeic.jpg";
      }
    } catch (e) {
      print("Lỗi khi tải ảnh lên Firebase: $e");
    }
    return null;
  }

  // Thêm sản phẩm vào Firestore
  Future<void> _addProduct() async {
    final imagePath = await _uploadImage(); // Lấy URL ảnh từ Firebase Storage

    final productData = {
      'name': _nameController.text,
      'price': int.parse(_priceController.text),
      'quantity': int.parse(_quantityController.text),
      'description': _descriptionController.text,
      'imagePath': imagePath ?? '', // Nếu không có ảnh thì để trống
    };

    try {
      // Thêm sản phẩm vào Firestore
      await FirebaseFirestore.instance.collection('products').add(productData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sản phẩm đã được thêm thành công!',
            style: TextStyle(
              color: AppColors.background, // Chỉnh màu chữ
              fontSize: 16, // Chỉnh kích thước chữ
            ),
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

  // Reset form
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
          title: "Quản lý sản phẩm",
          onItemTapped: (value) {
            widget.onNavigate(value);
          },
        ),
        body: SingleChildScrollView(
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
    );
  }
}
