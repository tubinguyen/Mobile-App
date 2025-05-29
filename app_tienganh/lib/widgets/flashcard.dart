import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Flashcard extends StatefulWidget {
  final String word;
  final String translation;
  final bool initialSide;
  final VoidCallback? onFlip;

  const Flashcard({
    super.key,
    required this.word,
    required this.translation,
    this.initialSide = false,
    this.onFlip,
  });

  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  late FlutterTts flutterTts;
  late GlobalKey<FlipCardState> cardKey;

  @override
  void initState() {
    super.initState();
    // Khởi tạo FlutterTts
    flutterTts = FlutterTts();
    cardKey = GlobalKey<FlipCardState>();

    // Cấu hình ban đầu cho TTS
    _setupTts();
  }

  Future<void> _setupTts() async {
    // Đặt ngôn ngữ - bạn có thể thay đổi tùy theo nhu cầu
    await flutterTts.setLanguage('en-US');

    // Điều chỉnh âm lượng
    await flutterTts.setVolume(1.0);

    // Điều chỉnh tốc độ phát âm
    await flutterTts.setSpeechRate(0.5);
  }

  Future<void> _speak(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  Widget _buildCard(String text, {bool isBack = false}) {
    return Container(
      width: 372,
      height: 449,
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
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(
                Icons.volume_up,
                color: AppColors.highlightDarkest,
              ),
              onPressed: () => _speak(text),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Giải phóng tài nguyên khi widget bị hủy
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: cardKey,
      direction: FlipDirection.HORIZONTAL, // Lật ngang
      front: _buildCard(widget.word),
      back: _buildCard(widget.translation, isBack: true),
      onFlip: widget.onFlip,
    );
  }
}
