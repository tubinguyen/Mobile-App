import 'package:app_tienganh/widgets/large_button_secondary.dart';
import 'package:app_tienganh/widgets/large_button.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/line.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import 'package:app_tienganh/widgets/number_input_field.dart';
import 'package:app_tienganh/widgets/toggle.dart';
import '../../widgets/text_input.dart';
import 'package:app_tienganh/widgets/result_exam.dart';
import 'package:app_tienganh/services/learning_module_service.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/user_model.dart';



class Vocab {
  final String word;
  final String meaning;

  Vocab({required this.word, required this.meaning});
}

enum QuestionType { multipleChoice, essay }

class Question {
  final QuestionType type;
  final String vocab;
  final String correctAnswer;
  final List<String>? options;

  Question({
    required this.type,
    required this.vocab,
    required this.correctAnswer,
    this.options,
  });
}

class QuestionResult {
  final int index;
  final String vocab;
  final String correctAnswer;
  String? userAnswer;
  final List<String>? options;

  QuestionResult({this.index = 0, required this.vocab, required this.correctAnswer, this.userAnswer, this.options});
}

class TestScreen extends StatefulWidget {
  final String moduleId;
  final Function(int, {String? moduleId}) onNavigate;

  const TestScreen({
    super.key,
    required this.moduleId,
    required this.onNavigate,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final LearningModuleService _learningModuleService = LearningModuleService();

  late Future<LearningModuleModel?> _learningModuleFuture;
  

  int currentScreen = 0; // 0: TestSettingScreen, 1: MultipleChoiceTestScreen, 2: EssayTestScreen 3: ResultScreen
  bool isMultipleChoice = false;
  bool isEssay = true;
 

  List<Vocab> vocabList = [
    Vocab(word: 'Apple', meaning: 'Quả táo'),
    Vocab(word: 'Dog', meaning: 'Con chó'),
    Vocab(word: 'Sun', meaning: 'Mặt trời'),
    Vocab(word: 'Book', meaning: 'Cuốn sách'),
    Vocab(word: 'Chair', meaning: 'Cái ghế'),
    Vocab(word: 'Water', meaning: 'Nước'),
    Vocab(word: 'Phone', meaning: 'Điện thoại'),
    Vocab(word: 'Tree', meaning: 'Cái cây'),
  ];
  int totalQuestions = 1;

  @override
  void initState() {
    super.initState();
    if (widget.moduleId.isEmpty) {
      print("Error: moduleId is empty");
      return;
    }
    _learningModuleFuture = _learningModuleService.getLearningModuleById(widget.moduleId);
  }

  List<Question> multipleChoiceQuestions = [];
  List<Question> essayQuestions = [];
  List<QuestionResult> userResults = [];
  int totalCorrect = 0;
  int currentQuestionIndex = 0;
  bool isFinished = false;
  int current = 1;


void generateQuestions(List<Vocab> vocabList) {
  final shuffled = List<Vocab>.from(vocabList)..shuffle();
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

    multipleChoiceQuestions.add(Question(
      type: QuestionType.multipleChoice,
      vocab: vocab.word,
      correctAnswer: correct,
      options: options,
    ));
  }

  // Tạo câu hỏi Tự luận
  for (int i = multipleChoiceCount; i < multipleChoiceCount + essayCount; i++) {
    final vocab = selected[i];
    essayQuestions.add(Question(
      type: QuestionType.essay,
      vocab: vocab.word,
      correctAnswer: vocab.meaning,
    ));
  }
  for (int i = 0; i < ( multipleChoiceQuestions.length); i++) {
    print(multipleChoiceQuestions[i].vocab); // In ra loại câu hỏi
    // print(essayQuestions[i].vocab); // In ra đáp án đúng
  }
  for (int i = 0; i < (essayQuestions.length ); i++) {
    print(essayQuestions[i].vocab); // In ra loại câu hỏi
    // print(essayQuestions[i].vocab); // In ra đáp án đúng
  }
}


void submitAnswer(String answer) {
  final currentQuestion = currentScreen == 1
      ? multipleChoiceQuestions[currentQuestionIndex]
      : essayQuestions[currentQuestionIndex];
  final isCorrect = currentQuestion.correctAnswer.toLowerCase() == answer.toLowerCase();

  userResults.add(QuestionResult(
    index: current,
    vocab: currentQuestion.vocab,
    correctAnswer: currentQuestion.correctAnswer,
    userAnswer: answer,
    options: currentScreen == 1 ? multipleChoiceQuestions[currentQuestionIndex].options : null,
  ));

  if (isCorrect) totalCorrect++;

  setState(() {
    if (currentScreen == 1 && currentQuestionIndex < multipleChoiceQuestions.length - 1) {
      currentQuestionIndex++;
      print(currentQuestionIndex);
    } else if (currentScreen == 2 && currentQuestionIndex < essayQuestions.length - 1) {
      currentQuestionIndex++;
      print(currentQuestionIndex);
    } else {
      // Chuyển sang màn hình tiếp theo
      if (currentScreen == 1 && isEssay) {
        currentScreen = 2; // Chuyển sang màn hình Tự luận
        currentQuestionIndex = 0; // Reset chỉ số câu hỏi cho Tự luận
        print(currentQuestionIndex);
      } else {
        currentScreen = 3; // Chuyển sang màn hình kết quả
        print(currentQuestionIndex);
      }
    }
  });
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
    case 3: // Màn hình kết quả
      body = _buildResultScreen();
      break;
    default:
      body = _buildTestSettingScreen(); // Mặc định quay lại màn hình thiết lập
  }

  return Scaffold(
    appBar: CustomNavBar(
      title: currentScreen == 0
          ? "Thiết lập bài kiểm tra"
          : currentScreen == 3
              ? "Kết quả"
              : "Câu hỏi", // Tên màn hình
      leadingIconPath: 'assets/img/cross-svgrepo-com.svg',
      onLeadingPressed: () {
        if (currentScreen != 3) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white, // Nền màu trắng
                title: Text(
                  "Xác nhận",
                  style: const TextStyle(
                    fontFamily: 'Montserrat', // Font Montserrat
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                  ),
                ),
                content: Text(
                  "Bạn có chắc chắn dừng làm bài kiểm không? Kết quả sẽ không được lưu.",
                  style: const TextStyle(
                    fontFamily: 'Montserrat', // Font Montserrat
                    color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Đóng popup
                    },
                    child: const Text(
                      "Không",
                      style: TextStyle(
                        fontFamily: 'Montserrat', // Font Montserrat
                        color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Đóng popup
                      widget.onNavigate(1); // Quay lại trang trước đó
                      resetPage(); // Đặt lại trạng thái
                    },
                    child: const Text(
                      "Có",
                      style: TextStyle(
                        fontFamily: 'Montserrat', // Font Montserrat
                        color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          resetPage(); // Đặt lại trạng thái
          switchScreen(0); // Quay lại màn hình thiết lập

        }
      },
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: body,
        ),
      ),
    ),
  );
}

Widget _buildTestSettingScreen() {
  final TextEditingController questionCountController = TextEditingController(text: "1");

  return FutureBuilder<LearningModuleModel?>(
    future: _learningModuleFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshot.hasError || snapshot.data == null) {
        return const Center(
          child: Text("Không tìm thấy dữ liệu học phần."),
        );
      }

      final learningModule = snapshot.data!;
final vocabList = learningModule.vocabulary
          .map((vocab) => Vocab(word: vocab.word, meaning: vocab.meaning))
          .toList();
      return Padding(
        padding: const EdgeInsets.all(16.0), // Thêm padding xung quanh toàn bộ nội dung
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
                    max: learningModule.totalWords, // Giới hạn số câu hỏi tối đa bằng số từ vựng
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
                onTap: () {
                  if (totalQuestions > learningModule.totalWords || totalQuestions < 1) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.background, // Nền màu trắng
                          title: Text(
                            "Lỗi",
                            style: const TextStyle(
                              fontFamily: 'Montserrat', // Font Montserrat
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                            ),
                          ),
                          content: Text(
                            "Số câu hỏi không được vượt quá số từ vựng có sẵn.",
                            style: const TextStyle(
                              fontFamily: 'Montserrat', // Font Montserrat
                              color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                  fontFamily: 'Montserrat', // Font Montserrat
                                  color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
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
                                color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            content: Text(
                              "Bạn phải chọn ít nhất một hình thức câu hỏi.",
                              style: const TextStyle(
                                fontFamily: 'Montserrat', // Font Montserrat
                                color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat', // Font Montserrat
                                    color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (isEssay && isMultipleChoice && totalQuestions == 1) {
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
                                color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            content: Text(
                              "Bạn không thể chọn cả hai hình thức câu hỏi.",
                              style: const TextStyle(
                                fontFamily: 'Montserrat', // Font Montserrat
                                color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat', // Font Montserrat
                                    color: AppColors.textPrimary, // Chữ màu AppColors.textPrimary
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                    generateQuestions(vocabList);
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
    }
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
          // "${currentQuestionIndex + 1}/${multipleChoiceQuestions.length + essayQuestions.length}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.yellow,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Text(
        currentQuestion.vocab,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.highlightDarkest,
          fontFamily: 'Montserrat',
        ),
      ),
      const SizedBox(height: 20),
      ...?currentQuestion.options?.map((option) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: LargeButtonSecondary(
              text: option,
              onTap: () {
                current ++;
                submitAnswer(option);
              },
            ),
          )),
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
              // "${currentQuestionIndex + 1}/${essayQuestions.length + multipleChoiceQuestions.length}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.yellow,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            currentQuestion.vocab,
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
                  current ++;
                  final answer = answerController.text.trim().isEmpty ? '' : answerController.text.trim();
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


Widget _buildResultScreen() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kết quả của bạn: $totalCorrect / ${userResults.length}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.highlightDarkest,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 20),
        ResultExamCustom(
          totalQuestions: totalQuestions,
          correctAnswers: totalCorrect,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Căn giữa các nút
              children: [
                Expanded(
                  child: LargeButtonSecondary(
                    text: "Ôn tập",
                    onTap: () => {widget.onNavigate(16), resetPage()}, // Điều hướng về trang ôn tập
                  ),
                ),
                const SizedBox(width: 20), // Khoảng cách giữa hai nút
                Expanded(
                  child: LargeButton(
                    text: "Làm kiểm tra lại",
                    onTap: () => {widget.onNavigate(15), resetPage()}, // Điều hướng về trang làm kiểm tra lại
                  ),
                ),
              ],
            ),
          ),
        ),

        ...userResults.map((result) {
          final isCorrect = result.userAnswer == result.correctAnswer;

          if (result.options != null) {
            // Nhiều lựa chọn
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Câu ${result.index - 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.highlightDarkest,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 8.0), // Khoảng cách giữa Text và Card
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.background, // Màu nền
                      borderRadius: BorderRadius.circular(12.0), // Bo góc
                      border: Border.all(
                        color: isCorrect ? AppColors.green : AppColors.red, // Màu viền
                        width: 1.0, // Độ dày viền
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding bên trong Container
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result.vocab,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.textPrimary,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          ...result.options!.map((option) {
                            final isOptionCorrect = option == result.correctAnswer;
                            final isUserAnswer = option == result.userAnswer;
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
                                onTap: () {}, // Không làm gì khi bấm
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
                  "Câu ${result.index - 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.highlightDarkest,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 8.0), // Khoảng cách giữa Text và Card
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background, // Màu nền
                      borderRadius: BorderRadius.circular(12.0), // Bo góc
                      border: Border.all(
                        color: isCorrect ? AppColors.green : AppColors.red, // Màu viền
                        width: 1.0, // Độ dày viền
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result.vocab,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.textPrimary,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextInput(
                            controller: TextEditingController(text: result.userAnswer ?? "Chưa trả lời"),
                            enabled: false, // Không cho chỉnh sửa
                            isError: !isCorrect, // Đổi màu viền dựa trên đúng/sai
                            label: "Câu trả lời của bạn",
                          ),
                          if (!isCorrect)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Đáp án đúng: ${result.correctAnswer}",
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

