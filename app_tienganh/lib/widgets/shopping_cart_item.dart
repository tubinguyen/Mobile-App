import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/number_input_field.dart';

class ShoppingCartItem extends StatefulWidget {
  final String imageName;
  final double price;
  final String title;
  final VoidCallback onRemove;

  const ShoppingCartItem({
    super.key,
    required this.imageName,
    required this.price,
    required this.title,
    required this.onRemove,
  });

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.price * quantity;

    return Container(
  width: 335,
  height: 100,
  padding: const EdgeInsets.symmetric(vertical: 5.0),
  child: Stack(
    children: [
      Row(
        children: [
          Image.asset(
            widget.imageName,
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 90,
                height: 100,
                color: AppColors.highlightLight,
                child: Icon(
                  Icons.broken_image,
                  color: AppColors.highlightDarkest50,
                ),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    '${widget.price.toStringAsFixed(0)} đ',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: NumberInputField(
                          min: 1,
                          max: 50,
                          initialValue: quantity,
                          onChanged: (value) {
                            setState(() {
                              quantity = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 36),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          '${totalPrice.toStringAsFixed(0)} VND',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Nút X nằm trên góc
      Positioned(
        top: 0,
        right: 0,
        child: IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: widget.onRemove,
        ),
      ),
    ],
  ),
);

  }
}
