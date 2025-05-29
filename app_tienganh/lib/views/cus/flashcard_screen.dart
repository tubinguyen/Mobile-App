import 'package:app_tienganh/widgets/flash_card_counter.dart';
import 'package:app_tienganh/widgets/flashcard.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import 'package:app_tienganh/widgets/recent_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app_tienganh/controllers/flashcard_controller.dart';
import 'package:app_tienganh/models/flashcard_model.dart';

class FlashcardScreen extends StatefulWidget {
    final String moduleId;
    final Function(int, {String? moduleId}) onNavigate;

    const FlashcardScreen({
    super.key, 
    required this.moduleId,
    required this.onNavigate});

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends State<FlashcardScreen> {
  int currentCard = 1;
  int totalCards = 0;
  bool isCompleted = false;
    bool _isLoading = true;

  final FlashCardService _flashCardService = FlashCardService();
  List <FlashcardModel> flashcards = [];

  @override
  void initState() {
    super.initState();
    // totalCards = vocabulary.length;
    _loadFlashcards();
  }

 Future<void> _loadFlashcards() async {
    final fetched = await _flashCardService.getFlashcardsByModuleId(widget.moduleId);
    setState(() {
      flashcards = fetched;
      totalCards = flashcards.length;
      currentCard = flashcards.isNotEmpty ? 1 : 0;
      _isLoading = false;
    });
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
      widget.onNavigate(6);
    } else {
      _nextCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Khi đang loading thì show loading indicator
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Khi không có từ vựng
    if (flashcards.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Học từ vựng"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const Center(
          child: Text(
            "Không có từ vựng nào để hiển thị.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    // Khi đã hoàn thành
    if (isCompleted) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/img/openmoji_return.svg', width: 32, height: 32),
            onPressed: () => widget.onNavigate(6),
          ),
          title: const Text('Kết quả', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                onTap: () => widget.onNavigate(15, moduleId: widget.moduleId),
              ),
            ),
          ],
        ),
      );
    }

    // Hiển thị flashcard
    final current = flashcards[currentCard - 1];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/img/openmoji_return.svg', width: 32, height: 32),
          onPressed: () => widget.onNavigate(12, moduleId: widget.moduleId),
        ),
        title: FlashcardCounter(currentCard: currentCard, totalCards: totalCards),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flashcard(
            key: ValueKey(currentCard),
            word: current.frontText,
            translation: current.backText,
          ),
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