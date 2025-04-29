import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/line_or.dart';
import 'package:app_tienganh/widgets/google_button.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/widgets/password.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/core/app_colors.dart';

class LoginScreen extends StatefulWidget {
  final Function(int) onNavigate;
  const LoginScreen({super.key, required this.onNavigate});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _handleLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Vui lòng nhập đầy đủ email và mật khẩu.");
    } else {
      widget.onNavigate(0); 
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

                const Center(child: LineOr()),
                const SizedBox(height: 16),

                GoogleSignInButton(
                  onTap: () {
                    widget.onNavigate(9); //Test
                  },
                ),
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
                        widget.onNavigate(8);
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
