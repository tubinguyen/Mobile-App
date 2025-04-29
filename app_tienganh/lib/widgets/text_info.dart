import 'package:flutter/material.dart';
import '../core/app_colors.dart';  // Giả sử bạn đã có `AppColors` trong project

class CustomTextField extends StatelessWidget {
  final String label; //nhãn của cái field
  final String content; //nội dung: email/ tên
  final bool readOnly;

  CustomTextField({
    required this.label,
    required this.content,
    this.readOnly = true, // Mặc định không cho chỉnh sửa
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 84,
      child: TextFormField(
        initialValue: content, // giá trị của field
        readOnly: readOnly, // không cho phép chỉnh sửa
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
          hintText: content,
          contentPadding: EdgeInsets.fromLTRB(19.5, 10, 0, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.hoverHighlightDarkest, // Màu viền mặc định
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.hoverHighlightDarkest, // Màu viền khi không focus
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder( //border field khi click vào
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.hoverHighlightDarkest, // Màu viền khi focus (click vào)
              width: 2, // Độ dày viền khi focus
            ),
          ),
          //color label khi click vào
        ),
      ),
    );
  }
}
