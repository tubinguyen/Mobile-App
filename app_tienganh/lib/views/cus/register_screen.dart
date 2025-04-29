import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/widgets/password.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/core/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  final Function(int) onNavigate;
  const RegisterScreen({super.key, required this.onNavigate});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isRegistering = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void _clearControllers() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void _handleRegister() {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar('Vui lòng điền đầy đủ thông tin.');
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar('Mật khẩu xác nhận không khớp.');
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thành công'),
          content: const Text('Đăng ký tài khoản thành công!'),
          actions: [
            LoginAndRegisterButton(
              text: 'Đăng nhập',
              onTap: () {
                Navigator.of(context).pop();
                _clearControllers();
                widget.onNavigate(6);
              },
              stateLoginOrRegister: AuthButtonState.login,
              textColor: AppColors.text,
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/logo.png',
                    height:  144,
                    width: 221,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isRegistering ? "Đăng ký" : "Chào mừng bạn đến với Eddy!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.highlightDarkest,
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (isRegistering)
                    Column(
                      children: [
                        TextInput(
                          label: 'Tên đăng nhập',
                          hint: 'Nhập tên đăng nhập',
                          enabled: true,
                          controller: usernameController,
                        ),
                        const SizedBox(height: 16),
                        TextInput(
                          label: 'Email',
                          hint: 'Nhập email',
                          enabled: true,
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                        PasswordInput(
                          label: 'Mật khẩu',
                          hint: 'Nhập mật khẩu',
                          enabled: true,
                          controller: passwordController,
                          showForgotPassword: false,
                        ),
                        const SizedBox(height: 16),
                        PasswordInput(
                          label: 'Xác nhận mật khẩu',
                          hint: 'Xác nhận mật khẩu',
                          enabled: true,
                          controller: confirmPasswordController,
                          showForgotPassword: false,
                        ),
                        const SizedBox(height: 16),
                        LoginAndRegisterButton(
                          text: 'Đăng ký tài khoản',
                          onTap: _handleRegister,
                          stateLoginOrRegister: AuthButtonState.login,
                          textColor: AppColors.text,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Bạn đã có tài khoản? ",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isRegistering = false;
                                  _clearControllers();
                                });
                              },
                              child: const Text(
                                "Đăng nhập",
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
                    )
                  else
                    Column(
                      children: [
                        const SizedBox(height: 40),
                        LoginAndRegisterButton(
                          text: 'Đăng nhập',
                          onTap: () => widget.onNavigate(6),
                          stateLoginOrRegister: AuthButtonState.login,
                          textColor: AppColors.text,
                        ),
                        const SizedBox(height: 16),
                        LoginAndRegisterButton(
                          text: 'Đăng ký',
                          onTap: () => setState(() => isRegistering = true),
                          stateLoginOrRegister: AuthButtonState.register,
                          textColor: AppColors.textPrimary,
                        ),
                        const SizedBox(height: 200),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
