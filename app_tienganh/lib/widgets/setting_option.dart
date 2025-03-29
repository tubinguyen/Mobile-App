import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';

class SettingOption extends StatefulWidget {
  final List<String> options; // Danh sách option truyền vào
  final List<Widget> pages; // Danh sách trang tương ứng
  final Function(String) onTap; // Callback khi chọn option

  const SettingOption({
    super.key,
    required this.options,
    required this.pages,
    required this.onTap,
  });

  @override
  _SettingOptionState createState() => _SettingOptionState();
}

class _SettingOptionState extends State<SettingOption> {
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
              trailing: const Text(
                "Chọn",
                style: TextStyle(
                  color: AppColors.highlightDarkest,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Chuyển đến trang tương ứng với option
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget.pages[index]),
                );

                setState(() {
                  settingOption = option; // Cập nhật option được chọn
                });

                print("Option setting: $settingOption"); // In ra console
                widget.onTap(option); // Gọi hàm callback khi chọn
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
// SettingOption(
//   options: ["Trang A", "Trang B"],
//   pages: [TestPage(), TestPage(), TestPage()], // Danh sách các trang tương ứng
//   onTap: (option) {
//     print("Bạn đã chọn: $option");
//   },
// ),
