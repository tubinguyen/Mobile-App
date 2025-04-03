import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class NumberInputField extends StatefulWidget {
  final int min;
  final int max;

  const NumberInputField({super.key, this.min = 0, this.max = 100});

  @override
  NumberInputFieldState createState() => NumberInputFieldState();
}

class NumberInputFieldState extends State<NumberInputField> {
  int _value = 1;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _value.toString());
  }

  void _updateValue(int newValue) {
    if (newValue >= widget.min && newValue <= widget.max) {
      setState(() {
        _value = newValue;
        _controller.text = _value.toString();
      });
    } else {
      _controller.text = _value.toString();
    }
  }

  void _onSubmitted(String input) {
    int? newValue = int.tryParse(input);
    if (newValue != null) {
      _updateValue(newValue);
    } else {
      _controller.text = _value.toString(); // Reset nếu nhập sai
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(12),
        // boxShadow: [BoxShadow(color: Colors.white, blurRadius: 0)],
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
                int? newValue = int.tryParse(input);
                if (newValue != null) {
                  _value = newValue; // Cập nhật ngay khi nhập
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
}


//cách dùng
// NumberInputField(
//   min: 0,
//   max: 50,
// ),
