import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_colors.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onBack;

  const ForgotPasswordWidget({
    super.key,
    required this.title,
    required this.description,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onBack, // Gọi hàm được truyền vào
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/img/arrow_left.svg',
                  colorFilter: const ColorFilter.mode(
                    AppColors.highlightDarkest,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30.0), 
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
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
        Padding(
          padding: const EdgeInsets.only(left: 54), 
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Montserrat',
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
