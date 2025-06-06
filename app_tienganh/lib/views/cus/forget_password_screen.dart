import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_tienganh/widgets/forgot_password.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/core/app_colors.dart';

enum ForgotPasswordStep {
  inputEmail,
  enterOTP,
  confirmReset,
  setNewPassword,
}

class ForgetPasswordScreen extends StatefulWidget {
  final Function(int) onNavigate;
  const ForgetPasswordScreen({super.key, required this.onNavigate});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ForgotPasswordStep _currentStep = ForgotPasswordStep.inputEmail;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _goToPreviousStep() {
    setState(() {
      switch (_currentStep) {
        case ForgotPasswordStep.enterOTP:
          _currentStep = ForgotPasswordStep.inputEmail;
          break;
        case ForgotPasswordStep.confirmReset:
          _currentStep = ForgotPasswordStep.enterOTP;
          break;
        case ForgotPasswordStep.setNewPassword:
          _currentStep = ForgotPasswordStep.confirmReset;
          break;
        default:
          break;
      }
    });
  }

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
                Text('Vui lòng kiểm tra email của bạn',
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
                Navigator.of(context).pop();
                widget.onNavigate(6);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _validateEmailInput() {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      _showSnackBar('Vui lòng nhập email!');
    } else {
      setState(() {
        _currentStep = ForgotPasswordStep.enterOTP;
      });
    }
  }

 Future<void> _validatePasswordInput() async {
    String email = _emailController.text.trim();

  if (email.isEmpty) {
      _showSnackBar('Vui lòng nhập email!');
    } 
    else 
    {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        _showSuccessDialog();
        setState(() {
          _currentStep = ForgotPasswordStep.inputEmail;
        });
      } on FirebaseAuthException catch (e) {
        String message = 'Đã xảy ra lỗi!';
        if (e.code == 'user-not-found') {
          message = 'Email không tồn tại!';
        } else if (e.code == 'invalid-email') {
          message = 'Email không hợp lệ!';
        }
        _showSnackBar(message);
      } catch (e) {
        _showSnackBar('Lỗi không xác định!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildStepContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        const SizedBox(height: 48),
        Image.asset('assets/img/logo.png', height: 144, width: 221),
        const SizedBox(height: 31),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case ForgotPasswordStep.inputEmail:
        return _buildEmailInputContent();
      // case ForgotPasswordStep.enterOTP:
      //   return _buildOTPSuccessContent();
      // case ForgotPasswordStep.confirmReset:
      //   return _buildNewPasswordContent();
      // case ForgotPasswordStep.setNewPassword:
      //   return _buildSetNewPasswordContent();
      default:
        return Container();
    }
  }

  Widget _buildEmailInputContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(),
        ForgotPasswordWidget(
          title: 'Quên mật khẩu',
          description: 'Vui lòng nhập email để đặt lại mật khẩu.',
          onBack: () => widget.onNavigate(6),
        ),
        const SizedBox(height: 45),
        TextInput(
          label: 'Email',
          hint: 'Nhập email đã đăng ký',
          enabled: true,
          controller: _emailController,
        ),
        const SizedBox(height: 23),
        LoginAndRegisterButton(
          text: 'Đặt lại mật khẩu',
          onTap: _validatePasswordInput, 
          stateLoginOrRegister: AuthButtonState.login,
          textColor: AppColors.text,
        ),
        const SizedBox(height: 350),
      ],
    );
  }

  // Widget _buildOTPSuccessContent() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       _buildLogo(),
  //       ForgotPasswordWidget(
  //         title: 'Kiểm tra email',
  //         description: 'Mã xác thực đã được gửi vào email của bạn.',
  //         onBack: _goToPreviousStep,
  //       ),
  //       const SizedBox(height: 43),
  //       OTP(),
  //       const SizedBox(height: 28),
  //       LoginAndRegisterButton(
  //         text: 'Gửi mã xác thực',
  //         onTap: () {
  //           setState(() {
  //             _currentStep = ForgotPasswordStep.confirmReset;
  //           });
  //         },
  //         stateLoginOrRegister: AuthButtonState.login,
  //         textColor: AppColors.text,
  //       ),
  //       const SizedBox(height: 18),
  //       GestureDetector(
  //         onTap: () {
  //         },
  //         child: const Text(
  //           'Gửi lại mã xác thực',
  //           style: TextStyle(
  //             fontFamily: 'Montserrat',
  //             fontSize: 16,
  //             color: AppColors.textPrimary,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 340),
  //     ],
  //   );
  // }

  // Widget _buildNewPasswordContent() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       _buildLogo(),
  //       ForgotPasswordWidget(
  //         title: 'Đặt lại mật khẩu',
  //         description: 'Chọn xác nhận để đặt lại mật khẩu mới.',
  //         onBack: _goToPreviousStep,
  //       ),
  //       const SizedBox(height: 40),
  //       LoginAndRegisterButton(
  //         text: 'Xác nhận',
  //         onTap: () {
  //           setState(() {
  //             _currentStep = ForgotPasswordStep.setNewPassword;
  //           });
  //         },
  //         stateLoginOrRegister: AuthButtonState.login,
  //         textColor: AppColors.text,
  //       ),
  //       const SizedBox(height: 350),
  //     ],
  //   );
  // }

  // Widget _buildSetNewPasswordContent() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       _buildLogo(),
  //       ForgotPasswordWidget(
  //         title: 'Đặt lại mật khẩu',
  //         description: 'Vui lòng nhập mật khẩu mới của bạn.',
  //         onBack: _goToPreviousStep,
  //       ),
  //       const SizedBox(height: 43),
  //       PasswordInput(
  //         label: 'Mật khẩu mới',
  //         enabled: true,
  //         showForgotPassword: false,
  //         controller: _newPasswordController,
  //       ),
  //       const SizedBox(height: 20),
  //       PasswordInput(
  //         label: 'Xác nhận mật khẩu mới',
  //         enabled: true,
  //         showForgotPassword: false,
  //         controller: _confirmPasswordController,
  //       ),
  //       const SizedBox(height: 29),
  //       LoginAndRegisterButton(
  //         text: 'Cập nhật mật khẩu',
  //         onTap: _validatePasswordInput, 
  //         stateLoginOrRegister: AuthButtonState.login,
  //         textColor: AppColors.text,
  //       ),
  //       const SizedBox(height: 350),
  //     ],
  //   );
  // }
}
