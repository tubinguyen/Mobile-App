import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class FlashcardCounter extends StatelessWidget {
  final int currentCard;
  final int totalCards;

  const FlashcardCounter({
    super.key,
    required this.currentCard,
    required this.totalCards,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: 105), // Dịch sang trái 20 pixel
        child: Text(
          '$currentCard/$totalCards',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.highlightDarkest,
          ),
        ),
      ),
    );
  }
}

// Ví dụ sử dụng
// FlashcardCounter(
//   currentCard: 1,
//   totalCards: 30,
// )
