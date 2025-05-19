import 'package:flutter/material.dart';
import '../../widgets/large_button.dart';
import '../../widgets/top_app_bar.dart';

class EditAccountScreen extends StatefulWidget {
  final Function(int) onNavigate;

  final String initialName;
  final String initialEmail;
  final String initialAddress;
  final String initialPhone;

  const EditAccountScreen({
    super.key,
    required this.onNavigate,
    required this.initialName,
    required this.initialEmail,
    required this.initialAddress,
    required this.initialPhone,
  });

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    emailController = TextEditingController(text: widget.initialEmail);
    addressController = TextEditingController(text: widget.initialAddress);
    phoneController = TextEditingController(text: widget.initialPhone);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // final updatedName = nameController.text;
    // final updatedEmail = emailController.text;
    // final updatedAddress = addressController.text;
    // final updatedPhone = phoneController.text;

   

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cập nhật thông tin thành công')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cập nhật thông tin  tài khoản",
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31, 20, 31, 20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tên'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Địa chỉ'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Số điện thoại'),
            ),
            const SizedBox(height: 30),
            LargeButton(
              text: 'Lưu thay đổi',
              onTap: _saveChanges,
            ),
          ],
        ),
      ),
    );
  }
}
