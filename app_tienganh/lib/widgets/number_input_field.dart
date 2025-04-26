import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class NumberInputField extends StatefulWidget {
  final int min;
  final int max;
  final TextEditingController? controller; // Thêm controller
  final ValueChanged<String>? onChanged; // Thêm callback onChanged

  const NumberInputField({
    super.key,
    this.min = 0,
    this.max = 100,
    this.controller,
    this.onChanged,
  });

  @override
  NumberInputFieldState createState() => NumberInputFieldState();
}

class NumberInputFieldState extends State<NumberInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.min.toString());
  }

  void _updateValue(int newValue) {
    if (newValue >= widget.min && newValue <= widget.max) {
      setState(() {
        _controller.text = newValue.toString();
        if (widget.onChanged != null) {
          widget.onChanged!(_controller.text); // Gọi callback onChanged
        }
      });
    }
  }

  void _onSubmitted(String input) {
    int? newValue = int.tryParse(input);
    if (newValue != null) {
      _updateValue(newValue);
    } else {
      _controller.text = widget.min.toString(); // Reset nếu nhập sai
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(Icons.remove, () => _updateValue(int.parse(_controller.text) - 1)),
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
                if (widget.onChanged != null) {
                  widget.onChanged!(input); // Gọi callback onChanged khi thay đổi
                }
              },
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          _buildButton(Icons.add, () => _updateValue(int.parse(_controller.text) + 1)),
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
//   min: 1,
//   max: vocabList.length, // Giới hạn số câu hỏi tối đa bằng số từ vựng
//   controller: questionCountController,
//   onChanged: (value) {
//     setState(() {
//       totalQuestions = int.tryParse(value) ?? 1; // Cập nhật số câu hỏi
//     });
//   },
// ),