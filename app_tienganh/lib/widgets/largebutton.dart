import 'package:flutter/material.dart';
import 'dart:developer';

class LargeButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const LargeButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: SizedBox(
        height: 40, 
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            log("Button '$text' pressed!");
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }
}


