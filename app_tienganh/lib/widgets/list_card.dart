import 'package:flutter/material.dart';
import '../../widgets/card.dart';

class ListCard extends StatelessWidget {
  final List<Map<String, String>> vocabularyList; // Danh sách từ vựng lấy từ DB sẽ kiểu
  // // List<Map<String, String>> với mỗi từ vựng là một Map chứa 'word' và 'meaning'
  // // Ví dụ: [{'word': 'hello', 'meaning': 'xin chào'}, {'word': 'world', 'meaning': 'thế giới'}]

  const ListCard({super.key, required this.vocabularyList});
@override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Tuỳ theo chiều cao card
      child: Stack(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vocabularyList.length,
            itemBuilder: (context, index) {
              final item = vocabularyList[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: VocabularyCard(
                  word: item['word']!,
                  meaning: item['meaning']!,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}