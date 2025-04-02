import 'package:flutter/material.dart';
import '../core/app_colors.dart'; 

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  // Danh sách controllers để theo dõi nội dung nhập vào từng ô
  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());

  // Danh sách FocusNode để kiểm soát luồng nhập liệu giữa các ô
  final List<FocusNode> _focusNodes =
      List.generate(5, (index) => FocusNode());

  // Danh sách trạng thái kiểm tra ô đã nhập hay chưa (mặc định là false)
  final List<bool> _isFilled = List.generate(5, (index) => false);

  @override
  void dispose() {
    // Giải phóng bộ nhớ cho controllers khi widget bị hủy
    for (var controller in _controllers) {
      controller.dispose();
    }
    // Giải phóng bộ nhớ cho focus nodes
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // Xử lý khi người dùng nhập hoặc xóa dữ liệu trong ô
  void _onChanged(String value, int index) {
    setState(() {
      _isFilled[index] = value.isNotEmpty; // Cập nhật trạng thái ô đã nhập hay chưa
    });

    if (value.isNotEmpty) {
      // Khi nhập, nếu chưa phải ô cuối cùng -> Chuyển focus sang ô kế tiếp
      if (index < 4) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus(); // Nếu là ô cuối cùng -> Bỏ focus
      }
    } else {
      // Khi xóa, nếu không phải ô đầu tiên -> Quay lại ô trước đó
      if (index > 0) {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Căn giữa các ô nhập OTP
      children: List.generate(5, (index) {
        return Container(
          width: 50, // Chiều rộng ô nhập
          height: 50, // Chiều cao ô nhập
          margin: const EdgeInsets.symmetric(horizontal: 10), // Khoảng cách giữa các ô
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), // Bo góc ô nhập
            border: Border.all(
              color: _isFilled[index] ? AppColors.highlightDarkest : AppColors.border, // Đổi màu viền khi có dữ liệu
              width: 2,
            ),
          ),
          child: TextField(
            controller: _controllers[index], // Gán controller để theo dõi nội dung nhập vào
            focusNode: _focusNodes[index], // Gán FocusNode để quản lý focus
            textAlign: TextAlign.center, // Căn giữa nội dung nhập
            maxLength: 1, // Chỉ cho phép nhập 1 ký tự
            keyboardType: TextInputType.number, // Chỉ cho phép nhập số
            cursorColor: Colors.black, // Chỉnh màu con trỏ thành đen
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.textPrimary, 
            ),
            decoration: const InputDecoration(
              counterText: "", // Ẩn bộ đếm ký tự mặc định của TextField
              border: InputBorder.none, // Ẩn viền mặc định của TextField
            ),
            onChanged: (value) => _onChanged(value, index), // Xử lý nhập và xóa
          ),
        );
      }),
    );
  }
}


//Cach su dung
// OTP(),