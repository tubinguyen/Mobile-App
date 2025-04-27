import 'package:app_tienganh/widgets/flash_card_counter.dart';
import 'package:app_tienganh/widgets/flashcard.dart';

import 'package:app_tienganh/widgets/premium_button.dart';
import 'package:app_tienganh/widgets/recent_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlashcardScreen extends StatefulWidget {
  final Function(int) onNavigate;
  const FlashcardScreen({super.key, required this.onNavigate});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<FlashcardScreen> {
  int currentCard = 1;
  int totalCards = 0;
  bool isCompleted = false;

  // Danh sách từ vựng và nghĩa
  List<Map<String, String>> vocabulary = [
    {"word": "family", "translation": "Gia đình"},
    {"word": "intuitive", "translation": "Trực quan"},
    {"word": "challenge", "translation": "Thử thách"},
    {"word": "adventure", "translation": "Cuộc phiêu lưu"},
    {"word": "success", "translation": "Thành công"},
    {"word": "communication", "translation": "Giao tiếp"},
    {"word": "knowledge", "translation": "Kiến thức"},
    {"word": "experience", "translation": "Trải nghiệm"},
    {"word": "journey", "translation": "Hành trình"},
    {"word": "learning", "translation": "Học tập"},
  ];

  @override
  void initState() {
    super.initState();
    totalCards = vocabulary.length;
  }

  void _nextCard() {
    if (currentCard < totalCards) {
      setState(() {
        currentCard++;
      });
    } else {
      // Đánh dấu hoàn thành khi đã xem hết các từ
      setState(() {
        isCompleted = true;
      });
    }
  }

  void _previousCard() {
    if (currentCard > 1) {
      setState(() {
        currentCard--;
        isCompleted = false; // Reset trạng thái hoàn thành nếu quay lại
      });
    }
  }

  void _handleContinueOrComplete() {
    if (isCompleted) {
      // Đã hoàn thành toàn bộ từ vựng
      widget.onNavigate(0);
    } else {
      _nextCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nếu đã hoàn thành, hiển thị màn hình kết quả
    if (isCompleted) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/img/openmoji_return.svg',
              width: 32,
              height: 32,
            ),
            onPressed: () => widget.onNavigate(0),
          ),
          title: const Text(
            'Kết quả',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: RecentActivity(
                title: "Tiến độ của bạn",
                status: "Đã hoàn thành",
                className: "Từ vựng TOEIC",
                note: "$totalCards/$totalCards từ vựng",
                buttonText: "Kiểm tra cũng cố",
                percentage: 100,
                onTap: () => widget.onNavigate(1),
              ),
            ),
          ],
        ),
      );
    }

    // Giao diện học từ vựng
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/img/openmoji_return.svg',
            width: 32,
            height: 32,
          ),
          onPressed: () => widget.onNavigate(0),
        ),
        title: FlashcardCounter(
          currentCard: currentCard,
          totalCards: totalCards,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Flashcard hiện tại
          Flashcard(
            key: ValueKey(currentCard),
            word: vocabulary[currentCard - 1]['word']!,
            translation: vocabulary[currentCard - 1]['translation']!,
          ),

          // Các nút điều khiển
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PremiumButton(
                  text: 'Quay lại',
                  onTap: _previousCard,
                  state: ButtonState.failure,
                  textColor: Colors.white,
                ),
                const SizedBox(width: 16),

                PremiumButton(
                  text: currentCard == totalCards ? 'Hoàn thành' : 'Tiếp tục',
                  onTap: _handleContinueOrComplete,
                  state: ButtonState.success,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
