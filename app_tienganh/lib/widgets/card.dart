import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:app_tienganh/core/app_colors.dart';

class VocabularyCard extends StatelessWidget {
  final String word;
  final String meaning;
  final FlutterTts _flutterTts = FlutterTts(); // Initialize FlutterTts

  VocabularyCard({super.key, required this.word, required this.meaning}) {
    // Configure TTS settings
    _flutterTts.setLanguage("en-US");
    _flutterTts.setPitch(1.0);
    _flutterTts.setSpeechRate(0.5);
  }

  // Function to speak the text
  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

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
                color:
                    isBack ? AppColors.highlightDarkest : AppColors.textPrimary,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          if (!isBack)
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.volume_up,
                  color: AppColors.highlightDarkest,
                ),
                onPressed: () => _speak(word), // Play pronunciation of the word
              ),
            ),
        ],
      ),
    );
  }
}
