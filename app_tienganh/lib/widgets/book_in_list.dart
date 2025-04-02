import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/small_button.dart'; 

class BookInList extends StatelessWidget {
  final String id;
  final String title;
  final String price;
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
        boxShadow: [
          BoxShadow(
            color: AppColors.blueLightest,
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
                    width: 200,
                    height: 120,
                    color: AppColors.blueLight, // Hiển thị màu xám nếu không load được ảnh
                    child: Icon(Icons.broken_image, color: AppColors.blueLightest),
                  );
                },
              ),
            ),

            const SizedBox(height: 8.0),
            // Tiêu đề sách
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontFamily: 'Montserrat',
                  fontSize: 16),
              ),
            ),
      
            const SizedBox(height: 8.0),
            // Giá sách
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
              child: Text(
                price,
                style: const TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: AppColors.textPrimary,),
              ),
            ),
            const SizedBox(height: 16.0),
            // Nút "Xem thêm"
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align (
                alignment: Alignment.center,
                  child: SmallButton(
                  text: 'Xem chi tiết',
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