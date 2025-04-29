import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';

class SettingOption extends StatefulWidget {
  final List<String> options; // Danh sách option truyền vào
  final List<int> pagesIndex; // Danh sách các trang tương ứng
  final List<String?>? selectedOption; // Biến lưu option được chọn
  final Function(int) onNavigate;

  const SettingOption({
    super.key,
    required this.options,
    required this.pagesIndex, 
    this.selectedOption,
    required this.onNavigate,
  });

  @override
  SettingOptionState createState() => SettingOptionState();
}

class SettingOptionState extends State<SettingOption> {
  String? settingOption; // Biến lưu option được chọn

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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              trailing: Text(
                (widget.selectedOption == null || widget.selectedOption!.length <= index || widget.selectedOption![index] == null)
                    ? "Chọn"
                    : widget.selectedOption![index]!,
                style: TextStyle(
                  color: AppColors.highlightDarkest,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                setState(() {
                  settingOption = option;
                });
                widget.onNavigate(widget.pagesIndex[index]); 
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


// // Cách gọi
// // SettingOption(options: ["Từ vựng","Giải nghĩa"], pagesIndex: [1,3], onNavigate: onNavigate,),
