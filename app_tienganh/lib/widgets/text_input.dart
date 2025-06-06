import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String hint;
  final bool enabled;
  final bool isError;
  final TextEditingController? controller;
  final int? maxLines; // Thêm tham số maxLines tùy chọn
  final TextInputType? keyboardType; // Thêm tham số keyboardType tùy chọn

  const TextInput({
    super.key,
    this.label = 'Email',
    this.hint = 'example@gmail.com',
    this.enabled = true,
    this.isError = false,
    this.controller,
    this.maxLines = 1, // Mặc định 1 dòng
    this.keyboardType = TextInputType.text, // Mặc định kiểu text
  });

  @override
  TextInputState createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color _getLabelColor() {
    if (!widget.enabled) return Colors.grey;
    if (widget.isError) return AppColors.red;
    return Colors.black;
  }

  Color _getBorderColor() {
    if (!widget.enabled) return Colors.grey;
    if (widget.isError) return AppColors.red;
    return _isFocused ? Colors.black : AppColors.border;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 349.0716247558594,
          height: widget.maxLines == 1 ? 56 : null,
          child: TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            enabled: widget.enabled,
            maxLines: widget.maxLines, // Sử dụng maxLines truyền vào
            keyboardType: widget.keyboardType,
            style: TextStyle(
              color:
                  widget.enabled
                      ? (widget.isError ? AppColors.red : Colors.black)
                      : Colors.grey,
              fontSize: 16,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(
                color: _getLabelColor(),
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: widget.enabled ? AppColors.border : Colors.grey.shade400,
                fontFamily: 'Montserrat',
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              filled: true,
              fillColor: widget.enabled ? Colors.white : AppColors.background,

              border: OutlineInputBorder(
                borderSide: BorderSide(color: _getBorderColor(), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _getBorderColor(), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _getBorderColor(), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Cách sử dụng
// Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextInput(
//                 enabled: true,

//           const SizedBox(height: 16),
//               // 🔴 Ô nhập có lỗi:
//               TextInput(
//                 enabled: true,
//                 isError: true, // ⚠️ Kích hoạt lỗi
//               ),
