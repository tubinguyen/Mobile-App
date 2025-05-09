import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/account.dart';
import '../../widgets/text_input.dart';
import '../../widgets/large_button.dart';
import '../../widgets/navbar.dart';

class UpdateProfileScreen extends StatefulWidget {

  final Function(int) onNavigate;
  final int? userId;
  const UpdateProfileScreen(
    {super.key,
    required this.onNavigate,
    this.userId,
    });

   @override
    State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>{
  int selectedIndex = 4;

  final String username = 'Nguyễn Phan Tú Bình';
  final String email = 'nhiyennguyen1905@gmail.com';
  final String password = 'hihihaha';
    final String address = 'Thành phố Hồ Chí Minh';
  final String sdt = '0123456789';
  
  //Pop up báo thành công
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 250,
            height: 200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/img/Success_Mark.png',
                    width: 70,
                    height: 70,
                ),
                SizedBox(height: 5),
                Text(
                  'Cập nhật thông tin thành công',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: AppColors.highlightDarkest,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ),
          
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng popup khi nhấn vào "OK"
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
Widget build(BuildContext context) { // chữ context viết thường nha
  return Scaffold(
    appBar: CustomNavBar(
        title: 'Thông tin tài khoản', 
        leadingIconPath: "assets/img/back.svg",
         onLeadingPressed: () {
          widget.onNavigate(4);
        },
        ),

    body: Center(
      child: SingleChildScrollView(
       child: Padding(
        padding: const EdgeInsets.fromLTRB(31, 10, 31, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // 🛠 thêm dòng này để canh giữa
          children: [
            //Account
            Account(profileImage: "assets/img/user.jpg", username: username),

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
            TextInput(
              label: 'Tên',
              hint: username,
            ),

            const SizedBox(height: 10),

            //Email
            TextInput(
              label: 'Email',
              hint: email,
            ),

            // const SizedBox(height: 10),
            // //Address
            // TextInput(
            //   label: 'Địa chỉ',
            //   hint: address,
            // ),
      
            // const SizedBox(height: 16),

            // //Số điện thoại
            // TextInput(
            //   label: 'Số điện thoại',
            //   hint: sdt,
            // ),
      
            const SizedBox(height: 16),

            //Đổi mật khẩu
            GestureDetector(
                onTap: () {
                  widget.onNavigate(19); 
                },
                child: Text(
                  'Đổi mật khẩu',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),

            const SizedBox(height: 16),

            LargeButton(
              text: 'Cập nhật thông tin', 
              onTap: () {
              //  ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(
              //         content: Text('Cập nhật thông tin thành công!'),
              //         duration: Duration(seconds: 2), // Thời gian hiển thị
              //         backgroundColor: Colors.green, // Màu nền của SnackBar
              //       ),
              //     );
              _showSuccessDialog();
              } )
          ],
        ),
      ),
    ),
    )
  );
}
}