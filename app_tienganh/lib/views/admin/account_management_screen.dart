import 'package:flutter/material.dart';
import '../../widgets/account.dart';
import '../../widgets/text_info.dart';
import '../../widgets/large_button.dart';
import '../../widgets/top_app_bar.dart';
import 'edit_account_screen.dart';

class AccountManagement extends StatefulWidget {

  final Function(int) onNavigate;
  final int? userId;
  const AccountManagement(
    {super.key,
    required this.onNavigate,
    this.userId,
    });

   @override
    State<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement>{
  int selectedIndex = 4;

  final String username = 'Nguyễn Phan Tú Bình';
  final String email = 'nhiyennguyen1905@gmail.com';
  final String password = 'hihihaha';
  final String address = 'Thành phố Hồ Chí Minh';
  final String sdt = '0123456789';

  @override
Widget build(BuildContext context) { 
  return Scaffold(
    appBar: CustomAppBar(
      title: "Quản lý tài khoản",
      onItemTapped: (value) {
        widget.onNavigate(value);
      },
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(31, 10, 31, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            const SizedBox(height: 20),
            Account(profileImage: "assets/img/user.jpg", username: username),
            const SizedBox(height: 20),
            Text(
              'Thông tin người dùng',
              style: TextStyle(
                fontFamily: 'Semibold',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
            CustomTextField(label: 'Tên', content: username,),
            CustomTextField(label: 'Email', content: email,),
            CustomTextField(label: 'Địa chỉ', content: address,),
            CustomTextField(label: 'Số điện thoại', content: sdt,),

           LargeButton(
            text: 'Cập nhật thông tin',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAccountScreen(
                    onNavigate: widget.onNavigate,
                    initialName: username,
                    initialEmail: email,
                    initialAddress: address,
                    initialPhone: sdt,
                  ),
                ),
              );
            },
          ),

          ],
        ),
      ),
    ),
  );
}
}
