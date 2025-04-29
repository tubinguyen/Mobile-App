// import 'package:app_tienganh/widgets/flash_card_counter.dart';
// import 'package:app_tienganh/widgets/flashcard.dart';
// import 'package:app_tienganh/widgets/large_button.dart';
// import 'package:app_tienganh/widgets/premium_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class FlashcardScreen extends StatefulWidget {
//   final Function(int) onNavigate;
//   const FlashcardScreen({super.key, required this.onNavigate});

//   @override
//   ReviewScreenState createState() => ReviewScreenState();
// }

// class ReviewScreenState extends State<FlashcardScreen> {
//   int currentCard = 1;
//   int totalCards = 0;
//   bool _isTranslationShown = false;

//   // Danh sách từ vựng và nghĩa
//   List<Map<String, String>> vocabulary = [
//     {"word": "family", "translation": "Gia đình"},
//     {"word": "intuitive", "translation": "Trực quan"},
//     {"word": "challenge", "translation": "Thử thách"},
//     {"word": "adventure", "translation": "Cuộc phiêu lưu"},
//     {"word": "success", "translation": "Thành công"},
//     {"word": "communication", "translation": "Giao tiếp"},
//     {"word": "knowledge", "translation": "Kiến thức"},
//     {"word": "experience", "translation": "Trải nghiệm"},
//     {"word": "journey", "translation": "Hành trình"},
//     {"word": "learning", "translation": "Học tập"},
//     {"word": "opportunity", "translation": "Cơ hội"},
//     {"word": "creativity", "translation": "Sáng tạo"},
//     {"word": "innovation", "translation": "Đổi mới"},
//     {"word": "persistence", "translation": "Kiên trì"},
//     {"word": "motivation", "translation": "Động lực"},
//     {"word": "collaboration", "translation": "Hợp tác"},
//     {"word": "empathy", "translation": "Sự đồng cảm"},
//     {"word": "resilience", "translation": "Sự kiên cường"},
//     {"word": "passion", "translation": "Đam mê"},
//     {"word": "leadership", "translation": "Lãnh đạo"},
//     {"word": "imagination", "translation": "Trí tưởng tượng"},
//     {"word": "integrity", "translation": "Tính liêm chính"},
//     {"word": "curiosity", "translation": "Tính tò mò"},
//     {"word": "dedication", "translation": "Sự tận tâm"},
//     {"word": "perspective", "translation": "Quan điểm"},
//     {"word": "potential", "translation": "Tiềm năng"},
//     {"word": "progress", "translation": "Tiến bộ"},
//     {"word": "mindset", "translation": "Tư duy"},
//     {"word": "connection", "translation": "Kết nối"},
//     {"word": "growth", "translation": "Sự phát triển"},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     totalCards = vocabulary.length;
//   }

//   void _nextCard() {
//     if (currentCard < totalCards) {
//       setState(() {
//         currentCard++;
//         // Khi chuyển sang thẻ mới, reset về mặt tiếng Anh
//         _isTranslationShown = false;
//       });
//     }
//   }

//   void _previousCard() {
//     if (currentCard > 1) {
//       setState(() {
//         currentCard--;
//         // Khi chuyển sang thẻ mới, reset về mặt tiếng Anh
//         _isTranslationShown = false;
//       });
//     }
//   }

//   void _toggleTranslation() {
//     setState(() {
//       _isTranslationShown = !_isTranslationShown;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: SvgPicture.asset(
//             'assets/img/openmoji_return.svg', // Đường dẫn đến file SVG
//             width: 32, // Điều chỉnh kích thước nếu cần
//             height: 32,
//           ),
//           onPressed: () => widget.onNavigate(0),
//         ),
//         title: FlashcardCounter(
//           currentCard: currentCard,
//           totalCards: totalCards,
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Flashcard hiện tại
//           Flashcard(
//             key: ValueKey('$currentCard-$_isTranslationShown'),
//             word: vocabulary[currentCard - 1]['word']!,
//             translation: vocabulary[currentCard - 1]['translation']!,
//             initialSide: _isTranslationShown,
//             onFlip: _toggleTranslation,
//           ),

//           // Các nút điều khiển
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 PremiumButton(
//                   text: 'Quay lại',
//                   onTap: _previousCard,
//                   state: ButtonState.failure,
//                   textColor: Colors.white,
//                 ),
//                 LargeButton(text: 'Tiếp tục', onTap: _nextCard),
//                 // PremiumButton(
//                 //   text: 'Tiếp tục',
//                 //   onTap: _nextCard,
//                 //   state:
//                 //       currentCard < totalCards
//                 //           ? ButtonState.success
//                 //           : ButtonState.failure,
//                 //   textColor: Colors.white,
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
