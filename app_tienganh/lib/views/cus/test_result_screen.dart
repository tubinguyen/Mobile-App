import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/large_button_secondary.dart';
import 'package:app_tienganh/widgets/large_button.dart';
import 'package:app_tienganh/widgets/result_exam.dart';
import 'package:app_tienganh/widgets/text_input.dart';
import 'package:app_tienganh/models/quiz_result_model.dart';
import 'package:app_tienganh/controllers/quiz_controller.dart';

class TestResultScreen extends StatelessWidget {
  final String quizResultId;
  // final String quizId;
  final String moduleId;
  final Function(int, {String? quizResultId, String? moduleId}) onNavigate;

  const TestResultScreen({super.key, required this.onNavigate, required this.quizResultId, required this.moduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<QuizResultModel?>(
          future: QuizController().getQuizResultByQuizResultId(quizResultId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("Không tìm thấy kết quả kiểm tra."));
            }
            final result = snapshot.data!;
            return Scaffold(
              appBar: CustomNavBar(
                title: "Kết quả",
                leadingIconPath: 'assets/img/cross-svgrepo-com.svg',
                onLeadingPressed: () {
                  onNavigate(12, moduleId: result.moduleId);
                },
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kết quả của bạn: ${result.correctAnswersCount} / ${result.questionResults.length}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.highlightDarkest,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ResultExamCustom(
                        totalQuestions: result.questionResults.length,
                        correctAnswers: result.correctAnswersCount,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: LargeButtonSecondary(
                                  text: "Ôn tập",
                                  onTap: () => onNavigate(16),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: LargeButton(
                                  text: "Làm kiểm tra lại",
                                  onTap: () => onNavigate(15, moduleId: result.moduleId),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ...result.questionResults.map((qr) {
                        final isCorrect = qr.userAnswer == qr.correctAnswer;
                        if (qr.options != null) {
                          // Nhiều lựa chọn
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "Câu ${qr.index - 1}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.highlightDarkest,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: isCorrect ? AppColors.green : AppColors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          qr.word,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: AppColors.textPrimary,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        ...qr.options!.map((option) {
                                          final isOptionCorrect = option == qr.correctAnswer;
                                          final isUserAnswer = option == qr.userAnswer;
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
                                            child: LargeButtonSecondary(
                                              text: option,
                                              borderSideColor: isOptionCorrect
                                                  ? AppColors.green
                                                  : (isUserAnswer ? AppColors.red : AppColors.highlightDarkest),
                                              textColor: isOptionCorrect
                                                  ? AppColors.green
                                                  : (isUserAnswer ? AppColors.red : AppColors.highlightDarkest),
                                              onTap: () {},
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          // Tự luận
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "Câu ${qr.index - 1}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.highlightDarkest,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: isCorrect ? AppColors.green : AppColors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          qr.word,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: AppColors.textPrimary,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        TextInput(
                                          controller: TextEditingController(text: qr.userAnswer ?? "Chưa trả lời"),
                                          enabled: false,
                                          isError: !isCorrect,
                                          label: "Câu trả lời của bạn",
                                        ),
                                        if (!isCorrect)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Đáp án đúng: ${qr.correctAnswer}",
                                              style: const TextStyle(
                                                color: AppColors.red,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }).toList(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}