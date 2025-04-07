import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter/material.dart';

class CardPairing extends StatelessWidget {
  static const String defaultState = 'defaultState';
  static const String select = 'select';
  static const String correct = 'correct';
  static const String wrong = 'wrong';

  // Properties to customize the box
  final String state;
  final String text;
  final TextStyle? textStyle;
  final double boxHeight;
  final double boxWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  const CardPairing({
    super.key,
    this.state = defaultState,
    this.text = 'text',
    this.textStyle,
    this.boxHeight = 121,
    this.boxWidth = 100,
    this.padding,
    this.margin,
    this.onTap,
  });

  // Method to get color based on state
  Color _getColorByState() {
    switch (state) {
      case defaultState:
        return AppColors.background;
      case select:
        return AppColors.blueLight;
      case correct:
        return AppColors.green;
      case wrong:
        return AppColors.red;
      default:
        return AppColors.background;
    }
  }

  // Method to get text color based on state
  Color _getTextColorByState() {
    switch (state) {
      case defaultState:
        return AppColors.textPrimary;
      case select:
        return AppColors.textPrimary;
      case correct:
        return AppColors.text;
      case wrong:
        return AppColors.text;
      default:
        return AppColors.textPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: boxHeight,
        width: boxWidth,
        margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
        padding: padding ?? const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _getColorByState(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.highlightDarkest,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style:
                textStyle ??
                TextStyle(
                  color: _getTextColorByState(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
          ),
        ),
      ),
    );
  }
}
