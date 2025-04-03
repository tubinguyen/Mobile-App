import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'package:app_tienganh/widgets/small_button.dart';  // Đảm bảo rằng bạn đã import SmallButton widget

class Book_small extends StatelessWidget {
  final String id; // Thêm biến id để truyền vào hàm navigate
  final String title;
  final double price;
  final String imageUrl;

  const Book_small({
    super.key,
    required this.id, // Thêm biến id vào constructor
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 200,
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
                width: 165,
                height: 94.67, // Tăng chiều cao lên để hình ảnh rõ hơn
                fit: BoxFit.fill, // Hoặc thử BoxFit.contain nếu ảnh bị méo
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 165,
                    height: 94.67,
                    color: AppColors.BlueLight, // Hiển thị màu xám nếu không load được ảnh
                    child: Icon(Icons.broken_image, color: AppColors.BlueLightest),
                  );
                },
              ),
            ),

            const SizedBox(height: 2.0),
            // Tiêu đề sách
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 5.0, 0),
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.highlightDarkest,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 15),
              ),
            ),
      
            const SizedBox(height: 1.0),
            // Giá sách
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
              child: Text(
                '${price.toStringAsFixed(0)} đ',
                style: const TextStyle(
                  fontSize: 14, 
                  fontFamily: 'Montserrat',
                  color: AppColors.textPrimary,),
              ),
            ),
            const SizedBox(height: 7.2),
            // Nút "Xem thêm"
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Align (
                alignment: Alignment.center,
                  child: SmallButton(
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