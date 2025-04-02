import 'package:flutter/material.dart';
import '../core/app_colors.dart'; // You'll need to create this file with your color definitions

// class PasswordInput extends StatefulWidget {
//   final String label;
//   final bool isError;
//   final bool enabled;
//   final bool
//   isHiddenPassword; // 🔹 Thêm biến này để điều khiển ẩn/hiện mật khẩu

//   const PasswordInput({
//     super.key,
//     required this.label,
//     this.isError = false,
//     this.enabled = true,
//     this.isHiddenPassword = true, // Mặc định là ẩn mật khẩu
//   });

//   @override
//   _PasswordInputState createState() => _PasswordInputState();
// }

// class _PasswordInputState extends State<PasswordInput> {
//   late bool isHiddenPassword; // 🔹 Sử dụng biến này thay cho `_isObscured`

//   @override
//   void initState() {
//     super.initState();
//     isHiddenPassword = widget.isHiddenPassword; // Gán giá trị mặc định
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//             fontFamily: 'Montserrat',
//           ),
//         ),
//         const SizedBox(height: 4),
//         SizedBox(
//           width: 349,
//           height: 56,
//           child: TextField(
//             obscureText:
//                 isHiddenPassword, // 🔹 Dùng biến này để kiểm soát ẩn/hiện mật khẩu
//             enabled: widget.enabled,
//             style: TextStyle(
//               color: widget.isError ? AppColors.red : AppColors.textPrimary,
//             ),
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 12,
//               ),
//               filled: !widget.enabled,
//               fillColor: widget.enabled ? Colors.white : AppColors.border,
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: widget.isError ? AppColors.red : AppColors.border,
//                   width: 1.5,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(
//                   color: AppColors.textPrimary,
//                   width: 1.5,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: AppColors.red, width: 1.5),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: AppColors.red, width: 1.5),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   isHiddenPassword ? Icons.visibility_off : Icons.visibility,
//                   color: Colors.grey,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isHiddenPassword = !isHiddenPassword; // 🔹 Đảo trạng thái
//                   });
//                 },
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 4),
//         // Căn "Quên mật khẩu" về bên trái
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 // Xử lý sự kiện quên mật khẩu
//               },
//               child: const Text(
//                 "Quên mật khẩu",
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.blue,
//                   fontFamily: 'Montserrat',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class TextInput extends StatefulWidget {
  final String label;
  final String hint;
  final bool enabled;
  final bool isError;
  final bool isHiddenPassword;
  final TextEditingController? controller;
  final VoidCallback? onForgotPassword;

  const TextInput({
    super.key,
    required this.label,
    required this.hint,
    this.enabled = true,
    this.isError = false,
    this.isHiddenPassword = false,
    this.controller,
    this.onForgotPassword,
  });

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isPasswordVisible = false;

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
          height: 56,
          child: TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            enabled: widget.enabled,
            obscureText: widget.isHiddenPassword && !_isPasswordVisible,
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
              labelStyle: TextStyle(color: _getLabelColor(), fontSize: 14),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: widget.enabled ? AppColors.border : Colors.grey.shade400,
                fontFamily: 'Montserrat',
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              filled: true,
              fillColor: widget.enabled ? Colors.white : Colors.grey.shade200,
              suffixIcon:
                  widget.isHiddenPassword
                      ? IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color:
                              widget.isError
                                  ? AppColors.red
                                  : _isFocused
                                  ? Colors.black
                                  : AppColors.border,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      )
                      : null,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: _getBorderColor(), width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _getBorderColor(), width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _getBorderColor(), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        if (widget.onForgotPassword != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: widget.onForgotPassword,
                child: const Text(
                  'Quên mật khẩu',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class PasswordInputScreen extends StatefulWidget {
  final List<Map<String, dynamic>> passwordFields;

  const PasswordInputScreen({super.key, required this.passwordFields});

  @override
  _PasswordInputScreenState createState() => _PasswordInputScreenState();
}

class _PasswordInputScreenState extends State<PasswordInputScreen> {
  late List<TextEditingController> _controllers;
  late List<bool> _isErrorStates;

  @override
  void initState() {
    super.initState();
    // Initialize controllers and error states based on input fields
    _controllers = List.generate(widget.passwordFields.length, (index) {
      final field = widget.passwordFields[index];
      return field['controller'] is TextEditingController
          ? field['controller']
          : TextEditingController();
    });
    _isErrorStates = List.filled(widget.passwordFields.length, false);
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showForgotPasswordDialog(int fieldNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quên Mật Khẩu'),
          content: Text('Bạn đang quên mật khẩu ở ô ${fieldNumber + 1}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đặt Lại Mật Khẩu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(widget.passwordFields.length, (index) {
            final field = widget.passwordFields[index];
            return Column(
              children: [
                TextInput(
                  label: field['label'] ?? 'Mật khẩu',
                  hint: field['hint'] ?? 'Nhập mật khẩu',
                  controller: _controllers[index],
                  isHiddenPassword: field['isHiddenPassword'] ?? true,
                  isError: _isErrorStates[index],
                  onForgotPassword: () => _showForgotPasswordDialog(index),
                ),
                if (index < widget.passwordFields.length - 1)
                  const SizedBox(height: 16),
              ],
            );
          }),
        ),
      ),
    );
  }
}
