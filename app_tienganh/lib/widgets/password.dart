import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class PasswordInput extends StatefulWidget {
  final String label;
  final String hint;
  final bool enabled;
  final bool isError;
  final TextEditingController? controller;
  final VoidCallback? onForgotPasswordTap;

  const PasswordInput({
    super.key,
    this.label = 'Mật khẩu',
    this.hint = 'Nhập mật khẩu',
    this.enabled = true,
    this.isError = false,
    this.controller,
    this.onForgotPasswordTap,
  });

  @override
  PasswordInputState createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isObscured = true;

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
    if (!widget.enabled) return AppColors.textPrimary;
    if (widget.isError) return AppColors.red;
    return Colors.black;
  }

  Color _getBorderColor() {
    if (!widget.enabled) return AppColors.border;
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
            obscureText: _isObscured,
            style: TextStyle(
              color:
                  widget.enabled
                      ? (widget.isError ? AppColors.red : AppColors.textPrimary)
                      : Colors.grey,
              fontSize: 16,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(color: _getLabelColor(), fontSize: 14),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color:
                    widget.enabled ? AppColors.border : AppColors.textSecondary,
                fontFamily: 'Montserrat',
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              filled: true,
              fillColor:
                  widget.enabled ? AppColors.background : AppColors.border,

              // Password visibility toggle
              suffixIcon:
                  widget.enabled
                      ? IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.border,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
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
                borderSide: BorderSide(color: AppColors.border, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        if (widget.enabled)
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: widget.onForgotPasswordTap,
                child: Text(
                  'Quên mật khẩu',
                  style: TextStyle(
                    color: AppColors.highlightDarkest,
                    fontSize: 16,
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
// cách sử dụng
// Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ERRoR Password Input
//               PasswordInput(
//                 enabled: true,
//                 isError: true,
//               ),

//               const SizedBox(height: 16),

//               // Password Input
//               PasswordInput(
//                 enabled: true,
//               ),
