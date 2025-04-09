import 'package:flutter/material.dart';
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
  FlashcardState createState() => FlashcardState();
}

class FlashcardState extends State<Flashcard> {
  late bool _isFrontSide;
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    _isFrontSide = !widget.initialSide;

    // Khởi tạo FlutterTts
    flutterTts = FlutterTts();

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

  void _toggleSide() {
    setState(() {
      _isFrontSide = !_isFrontSide;
      widget.onFlip?.call();
    });
  }

  @override
  void dispose() {
    // Giải phóng tài nguyên khi widget bị hủy
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSide,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationTransition(turns: animation, child: child);
        },
        child: _buildFlashcardContent(),
      ),
    );
  }

  Widget _buildFlashcardContent() {
    return Container(
      key: ValueKey<bool>(_isFrontSide),
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
              _isFrontSide ? widget.word : widget.translation,
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
              onPressed: () {
                // Phát âm từ hiện tại
                _speak(_isFrontSide ? widget.word : widget.translation);
              },
            ),
          ),
        ],
      ),
    );
  }
}
