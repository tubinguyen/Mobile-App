import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_tienganh/controllers/learning_module_controller.dart';
import 'package:app_tienganh/controllers/quiz_controller.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/quiz_result_model.dart';

class HomeController {
  final QuizController _quizController = QuizController();
  final LearningModuleController _learningModuleController =
      LearningModuleController();

  Future<Map<String, dynamic>?> fetchLatestActivity() async {
    try {
      // Kiểm tra trạng thái đăng nhập
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print(
          'HomeController: Người dùng chưa đăng nhập, không lấy hoạt động gần đây',
        );
        return null;
      }

      List<QuizResultModel> quizResults =
          await _quizController.getQuizResultsOfCurrentUser();
      if (quizResults.isEmpty) {
        print('HomeController: Không có kết quả bài kiểm tra nào');
        return null;
      }

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
      print('HomeController: Lỗi lấy hoạt động gần đây: $e');
      return null;
    }
  }
}
