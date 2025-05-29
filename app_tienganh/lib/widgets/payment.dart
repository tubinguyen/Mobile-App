import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Thêm import này
import '../core/app_colors.dart';

class Payment extends StatefulWidget {
  final String label;
  final List<String>? options;
  final String? subtitle;
  final String dropdownIconPath; // Giữ nguyên tên nhưng sẽ dùng cho SVG
  final Function(String)? onSelected;

  const Payment({
    super.key,
    required this.label,
    this.options,
    this.subtitle,
    this.dropdownIconPath = 'assets/img/ArrowDown.svg', // Đổi đuôi thành .svg
    this.onSelected,
  });

  @override
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  String? _selectedOption;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final GlobalKey _dropdownKey = GlobalKey();
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    final renderBox =
        _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
    final size = renderBox?.size ?? Size.zero;
    final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 5,
            width: size.width,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.border, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children:
                      widget.options?.map((String option) {
                        return ListTile(
                          title: Text(option),
                          onTap: () {
                            setState(() {
                              _selectedOption = option;
                              _removeOverlay();
                            });
                            widget.onSelected?.call(option);
                          },
                        );
                      }).toList() ??
                      [],
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 8),
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            key: _dropdownKey,
            onTap: _toggleDropdown,
            child: Container(
              width: 372,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedOption ?? "Chọn hình thức thanh toán",
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                  ),
                  // Thay thế Image.asset bằng SvgPicture.asset
                  SvgPicture.asset(
                    widget.dropdownIconPath,
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// Cách sử dụng
// Payment(
//                 label: 'Hình thức thanh toán',
//                 options: ['Thanh toán khi nhận hàng', 'Thanh toán qua VietQR'],
//               ),