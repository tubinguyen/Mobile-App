import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/account.dart';
import '../../widgets/password.dart';
import '../../widgets/large_button.dart';
import '../../widgets/navbar.dart';

class UpdatePasswordScreen extends StatefulWidget {

  final Function(int) onNavigate;
  final int? userId;
  const UpdatePasswordScreen(
    {super.key,
    required this.onNavigate,
    this.userId,
    });

   @override
    State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen>{
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
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/img/Success_Mark.png',
                  width: 70,
                  height: 70,
                ),
                SizedBox(height: 5,),
                Text('Cập nhật thông tin thành công',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  color: AppColors.highlightDarkest,
                  fontWeight: FontWeight.bold
                ),)
              ],
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
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomNavBar(
        title: 'Thông tin tài khoản', 
        leadingIconPath: "assets/img/back.svg",
         onLeadingPressed: () {
             widget.onNavigate(4); 
              },
        ),

    body: Center (
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(31, 10, 31, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
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

            //Mật khẩu hiện tại
            PasswordInput(
              label: 'Mật khẩu hiện tại',
              showForgotPassword: false,
            ),
            const SizedBox(height: 10),

            //Mật khẩu mới
            PasswordInput(
              label: 'Mật khẩu mới',        // Đặt nhãn cho trường mật khẩu
              hint: 'Nhập mật khẩu mới',    // Gợi ý người dùng nhập mật khẩu mới
              showForgotPassword: false,
              enabled: true,                // Trường có thể chỉnh sửa
              isError: false,               // Không có lỗi

            ),

            const SizedBox(height: 10),
            

            //Nhập lại mật khẩu
            PasswordInput(
              label: 'Nhập lại mật khẩu',      // Đặt nhãn cho trường nhập lại mật khẩu
              hint: 'Nhập lại mật khẩu của bạn', // Gợi ý người dùng nhập lại mật khẩu
              showForgotPassword: false,
              enabled: true,                   // Trường có thể chỉnh sửa
              isError: false,                  // Không có lỗi
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