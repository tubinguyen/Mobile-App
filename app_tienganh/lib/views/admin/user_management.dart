import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/user_account_inf.dart';
import 'package:app_tienganh/core/app_colors.dart';
class UserManagement extends StatelessWidget {
  final Function(int) onNavigate;

  const UserManagement({super.key, required this.onNavigate});

  final List<Map<String, dynamic>> users = const [
    {
      'name': "Tú Bình",
      'accountType': "Thường",
      'orderCount': 3,
      'courseCount': 4,
    },
    {
      'name': "Minh Anh",
      'accountType': "VIP",
      'orderCount': 10,
      'courseCount': 12,
    },
    {
      'name': "Khánh Linh",
      'accountType': "Thường",
      'orderCount': 1,
      'courseCount': 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quản lý người dùng",
        onItemTapped: (value) {
          onNavigate(value);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tổng số người dùng: ${users.length}', 
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat',color:  AppColors.highlightDarkest),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: UserInfoCard(
                      name: user['name'],
                      accountType: user['accountType'],
                      orderCount: user['orderCount'],
                      courseCount: user['courseCount'],
                      onDelete: () {
                        // Xử lý xóa user 
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
