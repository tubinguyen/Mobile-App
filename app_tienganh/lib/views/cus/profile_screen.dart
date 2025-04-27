// import 'package:app_tienganh/views/cus/home_screen.dart';
import 'package:flutter/material.dart';
import '../../widgets/account.dart';
import '../../widgets/yourorder.dart';
import '../../widgets/text_info.dart';
import '../../widgets/large_button.dart';

class ProfileScreen extends StatefulWidget {

  final Function(int) onNavigate;
  final int? userId;
  const ProfileScreen(
    {super.key,
    required this.onNavigate,
    this.userId,
    });

   @override
    State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  int selectedIndex = 4;

  final String username = 'Nguyễn Phan Tú Bình';
  final String email = 'nhiyennguyen1905@gmail.com';
  final String password = 'hihihaha';
  final String address = 'Thành phố Hồ Chí Minh';
  final String sdt = '0123456789';

  @override
Widget build(BuildContext context) { // chữ context viết thường nha
  return Scaffold(
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(31, 10, 31, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // 🛠 thêm dòng này để canh giữa
          children: [
            //Account
            Account(profileImage: "assets/img/user.jpg", username: username),

            const SizedBox(height: 35),

            YourOrder(
              text: 'Đơn hàng của bạn',
              onTap: () {
                widget.onNavigate(12);
              },
            ),

            const SizedBox(height: 29),

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

            //Tên
            // TextInput(
            //   label: 'Tên',
            //   hint: username,
            //   enabled: false,
            // ),

            CustomTextField(label: 'Tên', content: username,),

            //Email
            CustomTextField(label: 'Email', content: email,),
      
            //Address
            CustomTextField(label: 'Địa chỉ', content: address,),

            //Sdt
            CustomTextField(label: 'Số điện thoại', content: sdt,),

            LargeButton(
              text: 'Cập nhật thông tin', 
              onTap: () {
                widget.onNavigate(13);
              } )
          ],
        ),
      ),
    ),
  );
}
}