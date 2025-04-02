import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class Filter extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelected;

  const Filter({
    super.key,
    required this.options,
    required this.onSelected,
  });

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String? selectedOption;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _showDropdown();
    } else {
      _removeDropdown();
    }
  }

  void _showDropdown() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 150, // Giữ nguyên kích thước dropdown
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, 50), // Đặt dropdown ngay dưới button
          child: Material(
            // elevation: 4,//đổ bóng
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.background,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.options.map((option) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = option;
                      });
                      widget.onSelected(option);
                      _removeDropdown(); // Ẩn dropdown sau khi chọn
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: double.infinity, // Đảm bảo chữ không bị cắt
                      child: Align(
                        alignment: Alignment.centerLeft, // Căn chữ về bên trái
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
            color: AppColors.background,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedOption ?? "Lọc Theo",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat',
                  color: AppColors.textPrimary,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

//Cách sử dụng
// Filter(
//   options: ['Lọc theo Ngày', 'Lọc theo Tháng', 'Lọc theo Năm'],
//   onSelected: (String value) {
//     // Handle filter selection
//     print('Selected filter: $value');
//   },
// ),
