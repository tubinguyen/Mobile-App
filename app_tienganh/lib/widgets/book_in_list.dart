import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/large_button_secondary.dart';

class BookInList extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  const BookInList({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, 
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.background, 
        borderRadius: BorderRadius.circular(12), 
        boxShadow: [
          BoxShadow(
            color: AppColors.blueLight,
            blurRadius: 5, 
            spreadRadius: 1, 
            offset: const Offset(1, 2), 
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              width: 200,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 200,
                  height: 120,
                  color: AppColors.highlightLight,
                  child: Icon(Icons.broken_image, color: AppColors.hoverHighlightDarkest),
                );
              },
            ),
          ),

          const SizedBox(height: 8.0),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 4.0),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${price.toStringAsFixed(0)} đ',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: AppColors.textPrimary,
              ),
            ),
          ),

          const SizedBox(height: 12.0),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: LargeButtonSecondary(
                text: 'Xem thêm',
                onTap: () {},
                //Điều hướng đến trang xem chi tiết của sách
              ),
            ),
          ),

          const SizedBox(height: 12.0),
        ],
      ),
    );
  }
}
