import 'package:flutter/material.dart';
import 'premium_button.dart';
import '../core/app_colors.dart';

class BookInf extends StatelessWidget {
  final String name;
  final int price;
  final int quantity;
  final String description;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const BookInf({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 369,
      child: Card(
        color: Colors.white, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: AppColors.borderLight, 
            width: 1, 
          ),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0), 
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.asset(
                  'assets/img/user.jpg',
                  width: 135, 
                  height: 171,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20), 
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sách: $name',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: AppColors.highlightDarkest,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Giá: $price',
                      style: const TextStyle(fontSize: 10, fontFamily: 'Montserrat',fontWeight: FontWeight.normal,),
                    ),
                    Text(
                      'Số lượng: $quantity',
                      style: const TextStyle(fontSize: 10, fontFamily: 'Montserrat',fontWeight: FontWeight.normal,),
                    ),
                    Text(
                      'Mô tả sản phẩm: $description',
                      style: const TextStyle(fontSize: 10,  fontFamily: 'Montserrat',fontWeight: FontWeight.normal,),
                    ),
                    const SizedBox(height: 10), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        PremiumButton(
                          text: 'Xóa',
                          onTap: onDelete,
                          state: ButtonState.failure,
                          textColor: AppColors.text,
                        ),
                        const SizedBox(width: 5), 
                        PremiumButton(
                          text: 'Chỉnh sửa',
                          onTap: onEdit,
                          state: ButtonState.success,
                          textColor: AppColors.text,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//Cach su dung
// BookInf(
//   name: "Check your English Vocabulary for Toeic",
//   price: 200000,
//   quantity: 10,
//   description: "Sách TOEIC Preparation LC + RC Volume 1, 2",
//   onDelete: () {},
//   onEdit: () {},
// ),