import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/large_button.dart';


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
      height: 245,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.highlightLight,
        boxShadow: [
          BoxShadow(
            color: AppColors.highlightLight,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh bìa sách
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imageUrl,
                width: 200,
                height: 120, 
                fit: BoxFit.fill, // Hoặc thử BoxFit.contain nếu ảnh bị méo
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 165,
                    height: 94.67,
                    color: AppColors.highlightLight, // Hiển thị màu xám nếu không load được ảnh
                    child: Icon(Icons.broken_image, color: AppColors.hoverHighlightDarkest),
                  );
                },
              ),
            ),

            const SizedBox(height: 8.0),
            // Tiêu đề sách
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 5.0, 0),
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  
                  fontFamily: 'Montserrat',
                  fontSize: 14),
              ),
            ),
      
            const SizedBox(height: 4.0),
            // Giá sách
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
              child: Text(
                '${price.toStringAsFixed(0)} đ',
                style: const TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: AppColors.textPrimary,),
              ),
            ),
            const SizedBox(height: 8.0),
            // Nút "Xem thêm"
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Align (
                alignment: Alignment.center,
                  child: LargeButton(
                  text: 'Xem thêm',
                  onTap: () {
                    // Xử lý khi nhấn nút
                  //navigate phải truyền biến id sách 
                  },
                ),
              )
            ),
            const SizedBox(height: 16.0),
            
          ],
        ),
      ),
    );
  }
}