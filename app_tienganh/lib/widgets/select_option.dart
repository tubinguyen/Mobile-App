import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';

class SelectOption extends StatefulWidget {
  final List<String> options; // Danh sách option truyền vào
  final Function(String) onSelect; // Callback khi chọn option

  const SelectOption({
    super.key,
    required this.options,
    required this.onSelect,
  });

  @override
  _SelectOptionState createState() => _SelectOptionState();
}

class _SelectOptionState extends State<SelectOption> {
  String? selectedOption; // Biến lưu option được chọn

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.asMap().entries.map((entry) {
        final int index = entry.key;
        final String option = entry.value;
        final bool isLast = index == widget.options.length - 1; // Kiểm tra option cuối

        return Column(
          children: [
            _divider(), // Divider trên
            ListTile(
              title: Text(
                option,
                style: TextStyle(
                  fontWeight: selectedOption == option ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              trailing: selectedOption == option
                  ? const Icon(Icons.check, color: AppColors.highlightDarkest)
                  : null,
              onTap: () {
                setState(() {
                  selectedOption = option;
                  print("Option selected: $selectedOption"); // In ra console
                });
                widget.onSelect(option); // Gọi hàm callback khi chọn
              },
            ),
            if (isLast) _divider(), // Thêm _divider() phía dưới option cuối cùng
          ],
        );
      }).toList(),
    );
  }

  Widget _divider() {
    return Container(width: double.infinity, height: 0.5, color: AppColors.textSecondary);
  }
}


// Cách gọi
// SelectOption(
//   options: ["Option 1", "Option 2", "Option 3"],
//   onSelect: (option) {
//     print("Bạn đã chọn: $option");
//   },
// ),
