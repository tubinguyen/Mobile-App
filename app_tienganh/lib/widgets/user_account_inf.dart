import 'package:flutter/material.dart';
import 'premium_button.dart';
import '../core/app_colors.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String accountType;
  final int orderCount;
  final int courseCount;
  final VoidCallback onDelete;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.accountType,
    required this.orderCount,
    required this.courseCount,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 369,
      child: Card(
        color: AppColors.background, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: AppColors.blueLightest, 
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
                  width: 100, 
                  height: 124,
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
                      'Tên người dùng: $name',
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: AppColors.highlightDarkest,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tài khoản: $accountType',
                      style: const TextStyle(fontSize: 10, fontFamily: 'Montserrat',fontWeight: FontWeight.normal,),
                    ),
                    Text(
                      'Số lượng đơn hàng: $orderCount',
                      style: const TextStyle(fontSize: 10, fontFamily: 'Montserrat',fontWeight: FontWeight.normal,),
                    ),
                    Text(
                      'Số lượng học phần: $courseCount',
                      style: const TextStyle(fontSize: 10,  fontFamily: 'Montserrat',fontWeight: FontWeight.normal,),
                    ),
                    const SizedBox(height: 15), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        PremiumButton(
                          text: 'Xóa người dùng',
                          onTap: onDelete,
                          state: ButtonState.failure,
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
// UserInfoCard(
//   name: "Tú Bình",
//   accountType: "Thường",
//   orderCount: 3,
//   courseCount: 4,
//   onDelete: () {},
// ),