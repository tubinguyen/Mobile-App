import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final Widget destination;

  const SmallButton({
    super.key,
    required this.text,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30, 
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.highlightDarkest,
          side: BorderSide(color: AppColors.highlightDarkest, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.highlightDarkest,
            fontFamily: 'Montserrat',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
