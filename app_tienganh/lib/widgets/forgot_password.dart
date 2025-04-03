import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_colors.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/img/arrow_left.svg',
                  colorFilter: const ColorFilter.mode(AppColors.highlightDarkest, BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(width: 30.0), 
            const Expanded(
              child: Text(
                'Quên mật khẩu',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: AppColors.highlightDarkest,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4), 
        const Padding(
          padding: EdgeInsets.only(left: 54), 
          child: Text(
            'Vui lòng nhập email để đặt lại mật khẩu.',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Montserrat',
              color: AppColors.textPrimary
            ),
          ),
        ),
      ],
    );
  }
}

//Cach su dung
//ForgotPasswordWidget()