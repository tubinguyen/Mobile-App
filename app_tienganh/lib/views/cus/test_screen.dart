import 'package:app_tienganh/widgets/large_button_secondary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/line.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import 'package:app_tienganh/widgets/number_input_field.dart';
import 'package:app_tienganh/widgets/toggle.dart';
import '../../widgets/text_input.dart';
import 'package:app_tienganh/controllers/learning_module_controller.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/quiz_model.dart';
import 'package:app_tienganh/models/quiz_result_model.dart';
import 'package:app_tienganh/controllers/quiz_controller.dart';
import 'package:app_tienganh/controllers/notification_controller.dart';

class TestScreen extends StatefulWidget {
  final String moduleId;
  final Function(int, {String? moduleId, String? quizResultId}) onNavigate;

  const TestScreen({
    super.key,
    required this.moduleId,
    required this.onNavigate,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final LearningModuleController _learningModuleController =
      LearningModuleController();

  late Future<LearningModuleModel?> _learningModuleFuture;

  late String quizId;
  int currentScreen =
      0; // 0: TestSettingScreen, 1: MultipleChoiceTestScreen, 2: EssayTestScreen 3: ResultScreen
  bool isMultipleChoice = false;
  bool isEssay = true;
  int totalQuestions = 1;

  @override
  void initState() {
    super.initState();
    if (widget.moduleId.isEmpty) {
      print("Error: moduleId is empty");
      return;
    }
    _learningModuleFuture = _learningModuleController.getLearningModuleById(
      widget.moduleId,
    );
  }

  List<Question> multipleChoiceQuestions = [];
  List<Question> essayQuestions = [];
  List<QuestionResult> userResults = [];
  int totalCorrect = 0;
  int currentQuestionIndex = 0;
  bool isFinished = false;
  int current = 1;
  late DateTime startTime;

  void generateQuestions(List<VocabularyItem> vocabList) {
    final shuffled = List<VocabularyItem>.from(vocabList)..shuffle();
    final selected = shuffled.take(totalQuestions).toList();
    final allMeanings = vocabList.map((v) => v.meaning).toList();

    multipleChoiceQuestions.clear();
    essayQuestions.clear();

    int multipleChoiceCount = 0;
    int essayCount = 0;

    // Chia đều số lượng câu hỏi
    if (isMultipleChoice && isEssay) {
      int questionsPerType = totalQuestions ~/ 2;
      int remainingQuestions = totalQuestions % 2;

      multipleChoiceCount = questionsPerType + (remainingQuestions > 0 ? 1 : 0);
      essayCount = questionsPerType;
    } else if (isMultipleChoice) {
      multipleChoiceCount = totalQuestions;
    } else if (isEssay) {
      essayCount = totalQuestions;
    }

    // Tạo câu hỏi Nhiều lựa chọn
    for (int i = 0; i < multipleChoiceCount; i++) {
      final vocab = selected[i];
      final correct = vocab.meaning;
      final wrong = allMeanings.where((m) => m != correct).toList()..shuffle();
      final options = ([correct] + wrong.take(3).toList()).toList()..shuffle();

      multipleChoiceQuestions.add(
        Question(
          type: QuestionType.multipleChoice,
          word: vocab.word,
          correctAnswer: correct,
          options: options,
        ),
      );
    }

    // Tạo câu hỏi Tự luận
    for (
      int i = multipleChoiceCount;
      i < multipleChoiceCount + essayCount;
      i++
    ) {
      final vocab = selected[i];
      essayQuestions.add(
        Question(
          type: QuestionType.essay,
          word: vocab.word,
          correctAnswer: vocab.meaning,
        ),
      );
    }
    for (int i = 0; i < (multipleChoiceQuestions.length); i++) {
      print(multipleChoiceQuestions[i].word); // In ra loại câu hỏi
      // print(essayQuestions[i].vocab); // In ra đáp án đúng
    }
    for (int i = 0; i < (essayQuestions.length); i++) {
      print(essayQuestions[i].word); // In ra loại câu hỏi
      // print(essayQuestions[i].vocab); // In ra đáp án đúng
    }
  }

  Future<void> submitAnswer(String answer) async {
    final currentQuestion =
        currentScreen == 1
            ? multipleChoiceQuestions[currentQuestionIndex]
            : essayQuestions[currentQuestionIndex];
    final isCorrect =
        currentQuestion.correctAnswer.toLowerCase() == answer.toLowerCase();

    userResults.add(
      QuestionResult(
        index: current + 1,
        type:
            currentScreen == 1
                ? QuestionType.multipleChoice
                : QuestionType.essay,
        word: currentQuestion.word,
        correctAnswer: currentQuestion.correctAnswer,
        userAnswer: answer,
        options:
            currentScreen == 1
                ? multipleChoiceQuestions[currentQuestionIndex].options
                : null,
        isCorrect: isCorrect,
      ),
    );

    if (isCorrect) totalCorrect++;

    // Tăng current ở đây khi chuyển sang câu tiếp theo
    if (currentScreen == 1 &&
        currentQuestionIndex < multipleChoiceQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        current++;
      });
    } else if (currentScreen == 2 &&
        currentQuestionIndex < essayQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        current++;
      });
    } else {
      if (currentScreen == 1 && isEssay) {
        setState(() {
          currentScreen = 2;
          currentQuestionIndex = 0;
          // current không tăng ở đây vì sẽ là câu 1 của phần essay
        });
      } else {
        // Đã làm xong hết, lưu kết quả
        final notificationController = NotificationController();
        final quizResultId = await QuizController().saveQuizResult(
          quizId: quizId,
          moduleId: widget.moduleId,
          userId: FirebaseAuth.instance.currentUser!.uid,
          startTime: startTime,
          endTime: DateTime.now(),
          correctAnswersCount: totalCorrect,
          incorrectAnswersCount: userResults.length - totalCorrect,
          completionPercentage:
              userResults.isEmpty
                  ? 0
                  : (totalCorrect / userResults.length) * 100,
          questionResults: List<QuestionResult>.from(userResults),
        );
        if (quizResultId != "Lỗi khi lưu kết quả quiz.") {
          await notificationController.createQuizCompletionNotification(
            userId: FirebaseAuth.instance.currentUser!.uid,
            quizId: quizId,
            correctAnswersCount: totalCorrect,
            totalQuestions: userResults.length,
            moduleId: widget.moduleId,
          );
        }
        print('quizResultId: $quizResultId');
        widget.onNavigate(
          23,
          quizResultId: quizResultId,
          moduleId: widget.moduleId,
        );
      }
    }
  }

  //Quản lý trang
  void switchScreen(int screenIndex) {
    setState(() {
      currentScreen = screenIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (currentScreen) {
      case 0: // Màn hình thiết lập bài kiểm tra
        body = _buildTestSettingScreen();
        break;
      case 1: // Màn hình câu hỏi Nhiều lựa chọn
        body = _buildMultipleChoiceTestScreen();
        break;
      case 2: // Màn hình câu hỏi Tự luận
        body = _buildEssayTestScreen();
        break;
      default:
        body = _buildTestSettingScreen();
    }

    return Scaffold(
      appBar: CustomNavBar(
        title: currentScreen == 0 ? "Thiết lập bài kiểm tra" : "Câu hỏi",
        leadingIconPath: 'assets/img/cross-svgrepo-com.svg',
        onLeadingPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppColors.background,
                title: Text(
                  "Xác nhận",
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                content: Text(
                  "Bạn có chắc chắn dừng làm bài kiểm không? Kết quả sẽ không được lưu.",
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.textPrimary,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Không",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      widget.onNavigate(12, moduleId: widget.moduleId);
                      resetPage();
                      if (quizId.isNotEmpty) {
                        await QuizController().deleteQuiz(quizId);
                      }
                    },
                    child: const Text(
                      "Có",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(16.0), child: body),
        ),
      ),
    );
  }

  Widget _buildTestSettingScreen() {
    final TextEditingController questionCountController = TextEditingController(
      text: "1",
    );

    return FutureBuilder<LearningModuleModel?>(
      future: _learningModuleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text("Không tìm thấy dữ liệu học phần."));
        }

        final learningModule = snapshot.data!;
        final vocabList =
            learningModule.vocabulary
                .map(
                  (vocab) =>
                      VocabularyItem(word: vocab.word, meaning: vocab.meaning),
                )
                .toList();
        return Padding(
          padding: const EdgeInsets.all(
            16.0,
          ), // Thêm padding xung quanh toàn bộ nội dung
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                learningModule.moduleName, // Tên học phần (sẽ lấy từ database)
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.highlightDarkest,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Số câu hỏi",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100, // Đặt độ rộng cố định cho NumberInputField
                    child: NumberInputField(
                      min: 1,
                      max:
                          learningModule
                              .totalWords, // Giới hạn số câu hỏi tối đa bằng số từ vựng
                      controller: questionCountController,
                      onChanged: (value) {
                        setState(() {
                          totalQuestions = value; // Cập nhật số câu hỏi
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Line(width: 352),
              const SizedBox(height: 20),
              Text(
                "Hình thức câu hỏi",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.highlightDarkest,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Tự luận",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Toggle(
                    isOn: isEssay,
                    onToggle: (value) {
                      setState(() {
                        isEssay = value;
                        print("Tự luận: $isEssay");
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Nhiều lựa chọn",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Toggle(
                    isOn: isMultipleChoice,
                    onToggle: (value) {
                      setState(() {
                        isMultipleChoice = value;
                        print("Nhiều lựa chọn: $isMultipleChoice");
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: PremiumButton(
                  text: 'Bắt đầu kiểm tra',
                  onTap: () async {
                    if (totalQuestions > learningModule.totalWords ||
                        totalQuestions < 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor:
                                AppColors.background, // Nền màu trắng
                            title: Text(
                              "Lỗi",
                              style: const TextStyle(
                                fontFamily: 'Montserrat', // Font Montserrat
                                fontWeight: FontWeight.bold,
                                color:
                                    AppColors
                                        .textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            content: Text(
                              "Số câu hỏi không được vượt quá số từ vựng có sẵn.",
                              style: const TextStyle(
                                fontFamily: 'Montserrat', // Font Montserrat
                                color:
                                    AppColors
                                        .textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat', // Font Montserrat
                                    color:
                                        AppColors
                                            .textPrimary, // Chữ màu AppColors.textPrimary
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (!isMultipleChoice && !isEssay) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white, // Nền màu trắng
                            title: Text(
                              "Lỗi",
                              style: const TextStyle(
                                fontFamily: 'Montserrat', // Font Montserrat
                                fontWeight: FontWeight.bold,
                                color:
                                    AppColors
                                        .textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            content: Text(
                              "Bạn phải chọn ít nhất một hình thức câu hỏi.",
                              style: const TextStyle(
                                fontFamily: 'Montserrat', // Font Montserrat
                                color:
                                    AppColors
                                        .textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat', // Font Montserrat
                                    color:
                                        AppColors
                                            .textPrimary, // Chữ màu AppColors.textPrimary
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (isEssay &&
                        isMultipleChoice &&
                        totalQuestions == 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white, // Nền màu trắng
                            title: Text(
                              "Lỗi",
                              style: const TextStyle(
                                fontFamily: 'Montserrat', // Font Montserrat
                                fontWeight: FontWeight.bold,
                                color:
                                    AppColors
                                        .textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            content: Text(
                              "Bạn không thể chọn cả hai hình thức câu hỏi.",
                              style: const TextStyle(
                                fontFamily: 'Montserrat', // Font Montserrat
                                color:
                                    AppColors
                                        .textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat', // Font Montserrat
                                    color:
                                        AppColors
                                            .textPrimary, // Chữ màu AppColors.textPrimary
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      generateQuestions(vocabList);

                      // Gộp tất cả câu hỏi lại để lưu
                      List<Question> allQuestions = [
                        ...multipleChoiceQuestions,
                        ...essayQuestions,
                      ];

                      // Lưu quiz vào Firestore
                      final quizController = QuizController();
                      quizId = await quizController.createQuiz(
                        moduleId: learningModule.moduleId,
                        numberOfQuestions: totalQuestions,
                        questionList: allQuestions,
                      );
                      startTime = DateTime.now();
                      // Chuyển màn hình đầu tiên dựa vào loại câu hỏi
                      if (isMultipleChoice) {
                        switchScreen(1);
                      } else {
                        switchScreen(2);
                      }
                    }
                  },
                  state: ButtonState.premium,
                  textColor: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMultipleChoiceTestScreen() {
    final currentQuestion = multipleChoiceQuestions[currentQuestionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "$current/${multipleChoiceQuestions.length + essayQuestions.length}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.yellow,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          currentQuestion.word,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.highlightDarkest,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 20),
        ...?currentQuestion.options?.map(
          (option) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: LargeButtonSecondary(
              text: option,
              onTap: () {
                // current ++;
                submitAnswer(option);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEssayTestScreen() {
    final currentQuestion = essayQuestions[currentQuestionIndex];
    final TextEditingController answerController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "$current/${essayQuestions.length + multipleChoiceQuestions.length}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.yellow,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              currentQuestion.word,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.highlightDarkest,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 20),
            TextInput(
              controller: answerController,
              hint: "Nhập nghĩa của từ",
              label: "Câu trả lời",
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LargeButtonSecondary(
                  text: 'Xác nhận',
                  onTap: () {
                    // current ++;
                    final answer =
                        answerController.text.trim().isEmpty
                            ? ''
                            : answerController.text.trim();
                    submitAnswer(answer);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void resetPage() {
    setState(() {
      currentScreen = 0; // Quay lại màn hình thiết lập bài kiểm tra
      isFinished = false; // Đặt trạng thái bài kiểm tra chưa hoàn thành
      totalCorrect = 0; // Đặt lại số câu trả lời đúng
      totalQuestions = 1; // Đặt lại số câu hỏi
      currentQuestionIndex = 0; // Đặt lại chỉ số câu hỏi hiện tại
      current = 1; // Đặt lại chỉ số câu hỏi hiện tại
      userResults.clear(); // Xóa kết quả của người dùng
      multipleChoiceQuestions.clear(); // Xóa danh sách câu hỏi Nhiều lựa chọn
      essayQuestions.clear(); // Xóa danh sách câu hỏi Tự luận
      isEssay = true; // Đặt lại trạng thái Tự luận
      isMultipleChoice = false; // Đặt lại trạng thái Nhiều lựa chọn
    });
  }
}
