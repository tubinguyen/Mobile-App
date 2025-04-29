import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';

class VocabularyFlipCard extends StatelessWidget {
  final String word;
  final String meaning;

  const VocabularyFlipCard({
    super.key,
    required this.word,
    required this.meaning,
  });

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL, // Lật ngang
      front: _buildCard(word),
      back: _buildCard(meaning, isBack: true),
    );
  }

  Widget _buildCard(String text, {bool isBack = false}) {
    return Container(
      width: 288,
      height: 178,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.highlightDarkest),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isBack ? AppColors.highlightDarkest : AppColors.textPrimary,

                fontFamily: 'Montserrat',
              ),
            ),
          ),
          if (!isBack)
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.volume_up, color: AppColors.highlightDarkest),
                onPressed: () {
                  // TODO: Play pronunciation
                },
              ),
            ),
        ],
      ),
    );
  }
}
