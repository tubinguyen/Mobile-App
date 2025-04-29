import 'package:app_tienganh/widgets/percent.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ResultExamCustom extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  const ResultExamCustom({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int correctAnswersAdjusted = (totalQuestions > 0) ? correctAnswers : 0;
    int incorrectAnswers = (totalQuestions > 0) ? totalQuestions - correctAnswersAdjusted : 0;
    double percentage = (totalQuestions > 0) ? ((correctAnswersAdjusted / totalQuestions) * 100) : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircularProgressIndicatorCustom(
          progress: percentage / 100, // Chia cho 100 để chuyển đổi sang tỷ lệ 0.0 - 1.0
          size: 84.0,
          progressColor: AppColors.green,
          backgroundColor: AppColors.red,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.highlightDarkest,
          ),
        ),
        SizedBox(
          width: 128, //Điều chỉnh khoảng cách ngang giữa `CircularProgressIndicatorCustom` và `Column`
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Đúng: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.green,
                  ),
                ),
                Text(
                  "$correctAnswersAdjusted",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Sai: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.red,
                  ),
                ),
                Text(
                  "$incorrectAnswers",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// cách Gọi
// ResultExamCustom(
//   totalQuestions: 50,   // Tổng số câu hỏi
//   correctAnswers: 15,   // Số câu đúng
// ),