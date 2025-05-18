import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class NumberInputField extends StatefulWidget {
  final int min;
  final int max;
  final int initialValue;
  final TextEditingController? controller;
  final ValueChanged<int>? onChanged;

  const NumberInputField({
    super.key,
    this.min = 0,
    this.max = 100,
    this.initialValue = 1,
    this.controller,
    this.onChanged,
  });

  @override
  NumberInputFieldState createState() => NumberInputFieldState();
}

class NumberInputFieldState extends State<NumberInputField> {
  late int _value;
  late TextEditingController _controller;
  bool _isExternalController = false;
  late int _currentValue; // Biến lưu giá trị hiện tại

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _currentValue =
        widget.initialValue; // Khởi tạo giá trị hiện tại bằng giá trị ban đầu

    // Dùng controller bên ngoài nếu có, ngược lại thì tạo mới
    _isExternalController = widget.controller != null;
    _controller = widget.controller ??
        TextEditingController(text: _value.toString());

    // Đồng bộ ban đầu
    if (!_isExternalController) {
      _controller.text = _value.toString();
    }
  }

  void _updateValue(int newValue) {
    if (newValue >= widget.min && newValue <= widget.max) {
      setState(() {
        _value = newValue;
        _currentValue = newValue; // Cập nhật giá trị hiện tại khi giá trị thay đổi
        debugPrint(
            '_currentValue trong _updateValue: $_currentValue');
        _controller.text = _value.toString();
        widget.onChanged?.call(_value);
      });
    } else {
      _controller.text = _value.toString(); // Reset nếu vượt giới hạn
    }
  }

  void _onSubmitted(String input) {
    final newValue = int.tryParse(input);
    if (newValue != null) {
      _updateValue(newValue);
    } else {
      _controller.text = _value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(Icons.remove, () => _updateValue(_value - 1)),
          SizedBox(
            width: 50,
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
              onSubmitted: _onSubmitted,
              onChanged: (input) {
                final newValue = int.tryParse(input);
                if (newValue != null) {
                  _value = newValue;
                  _currentValue =
                      newValue; // Cập nhật giá trị hiện tại khi giá trị thay đổi từ TextField
                  widget.onChanged?.call(_value);
                }
              },
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          _buildButton(Icons.add, () => _updateValue(_value + 1)),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.highlightLight,
      ),
      child: Center(
        child: IconButton(
          icon: Icon(icon, color: AppColors.highlightDarkest, size: 12),
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
  int get currentValue => _currentValue; // Trả về giá trị hiện tại

}

