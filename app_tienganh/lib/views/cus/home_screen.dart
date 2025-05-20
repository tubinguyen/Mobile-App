import 'package:app_tienganh/controllers/learning_module_controller.dart';
import 'package:app_tienganh/controllers/quiz_controller.dart';
import 'package:app_tienganh/widgets/banner.dart';
import 'package:app_tienganh/widgets/book_list.dart';
import 'package:app_tienganh/widgets/recent_activity.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/quiz_result_model.dart';

class HomeScreen extends StatefulWidget {
  final Function(int, {String? moduleId}) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuizController _quizController = QuizController();
  final LearningModuleController _learningModuleController =
      LearningModuleController();

  late Future<Map<String, dynamic>?> _latestActivityFuture;

  @override
  void initState() {
    super.initState();
    _latestActivityFuture = _fetchLatestActivity();
  }

  Future<Map<String, dynamic>?> _fetchLatestActivity() async {
    try {
      List<QuizResultModel> quizResults =
          await _quizController.getQuizResultsOfCurrentUser();
      if (quizResults.isEmpty) return null;

      quizResults.sort((a, b) => b.endTime.compareTo(a.endTime));
      QuizResultModel latestQuiz = quizResults.first;

      LearningModuleModel? module = await _learningModuleController
          .getLearningModuleById(latestQuiz.moduleId);

      module ??= LearningModuleModel(
        moduleId: '',
        moduleName: 'Không xác định',
        description: null,
        vocabulary: [],
        totalWords: 0,
        userId: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return {'latestQuiz': latestQuiz, 'module': module};
    } catch (e) {
      print('Lỗi lấy hoạt động gần đây: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Danh sách đường dẫn hình ảnh cho slideshow
    final List<String> images = [
      'assets/img/poster1.png',
      'assets/img/poster2.png',
      'assets/img/poster3.png',
      'assets/img/poster4.png',
      'assets/img/poster5.png',
      'assets/img/poster6.png',
    ];

    return Scaffold(
      // SafeArea đảm bảo nội dung không bị che bởi thanh trạng thái
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 1,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Widget slideshow hiển thị hình ảnh
                  SlideshowWidget(
                    imagePaths: images,
                    duration: const Duration(seconds: 3),
                  ),

                  const SizedBox(height: 20),

                  // Khối hoạt động gần đây
                  FutureBuilder<Map<String, dynamic>?>(
                    future: _latestActivityFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text(
                          'Lỗi tải hoạt động gần đây: ${snapshot.error}',
                        );
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Text('Chưa có hoạt động gần đây');
                      }

                      final latestQuiz =
                          snapshot.data!['latestQuiz'] as QuizResultModel;
                      final module =
                          snapshot.data!['module'] as LearningModuleModel;

                      return RecentActivity(
                        title: "Hoạt động gần đây",
                        status: "Hoàn thành",
                        className: module.moduleName,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        note: "Tiếp tục nào",
                        buttonText: "Xem chi tiết",
                        percentage: latestQuiz.completionPercentage,
                        onTap:
                            () => widget.onNavigate(
                              12,
                              moduleId: module.moduleId,
                            ),
                      );
                    },
                  ),

                  //Khoảng cách giữa các thành phần
                  const SizedBox(height: 20),

                  // Danh sách sách
                  BookList(onNavigate: widget.onNavigate),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
