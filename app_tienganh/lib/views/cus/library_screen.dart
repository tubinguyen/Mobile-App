import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/login_and_register_button.dart';
import 'package:app_tienganh/core/app_colors.dart';

class LibraryScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const LibraryScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginAndRegisterButton(
          text: 'Dang nhap',
          onTap: () {
            onNavigate(14); // Sửa tại đây
          },
          stateLoginOrRegister: AuthButtonState.login,
          textColor: AppColors.text,
        ),
      ),
    );
  }
}