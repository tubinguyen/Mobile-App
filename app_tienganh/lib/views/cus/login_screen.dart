import 'package:app_tienganh/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:app_tienganh/widgets/line_or.dart';
// import 'package:app_tienganh/widgets/google_button.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/widgets/password.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:app_tienganh/models/user_model.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const LoginScreen({super.key, required this.onNavigate});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void resetFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', role);
    print(prefs.getString('userRole'));
  }

void _handleLogin() async {
  String email = _emailController.text.trim();
  String password = _passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    _showSnackBar("Vui lòng nhập đầy đủ email và mật khẩu.");
    return;
  }

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        UserModel userModel = UserModel.fromMap(
          userDoc.data() as Map<String, dynamic>,
          user.uid,
        );

        // // Lưu role vào SharedPreferences
        saveUserRole(userModel.role.toString());

        // Điều hướng theo role
        if (userModel.role == 1) {
          _showSnackBar("Chào Admin");
          widget.onNavigate(10);
        } else {
          _showSnackBar("Đăng nhập thành công ");
          widget.onNavigate(0);
        }
        resetFields();
      } else {
        _showSnackBar("Không tìm thấy thông tin người dùng.");
      }
    } else {
      _showSnackBar("Đăng nhập thất bại. Vui lòng thử lại.");
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-email') {
      _showSnackBar("Email không hợp lệ.");
    } else if (e.code == 'invalid-credential') {
      _showSnackBar("Đăng nhập thất bại. Vui lòng thử lại.");
    }
  } catch (e) {
    _showSnackBar("Đã xảy ra lỗi. Vui lòng thử lại.");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/logo.png',
                  height: 144,
                  width: 221,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Đăng nhập",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.highlightDarkest,
                  ),
                ),
                const SizedBox(height: 28),

                TextInput(
                  controller: _emailController,
                  enabled: true,
                ),
                const SizedBox(height: 16),

                PasswordInput(
                  controller: _passwordController,
                  enabled: true,
                  onForgotPasswordTap: () {
                    widget.onNavigate(7);
                    resetFields(); // Reset khi chuyển trang quên mật khẩu
                  },
                ),
                const SizedBox(height: 24),

                LoginAndRegisterButton(
                  text: 'Đăng nhập',
                  onTap: _handleLogin,
                  stateLoginOrRegister: AuthButtonState.login,
                  textColor: AppColors.text,
                ),
                const SizedBox(height: 16),
                

                // const Center(child: LineOr()),
                // const SizedBox(height: 16),

                // GoogleSignInButton(
                //   onTap: () async{
                //     _signInWithGoogle();
                //     // widget.onNavigate(9);
                //     resetFields();
                //   },
                // ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bạn chưa có tài khoản? ",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onNavigate(8); // Đăng ký
                        resetFields();
                      },
                      child: const Text(
                        "Đăng ký",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: AppColors.highlightDarkest,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
