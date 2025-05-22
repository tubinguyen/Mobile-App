import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_tienganh/controllers/home_screen_controller.dart';
import 'package:app_tienganh/widgets/banner.dart';
import 'package:app_tienganh/widgets/book_list.dart';
import 'package:app_tienganh/widgets/recent_activity.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/quiz_result_model.dart';
import 'package:app_tienganh/core/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final Function(int, {String? moduleId, String? quizResultId}) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = HomeController();
  late Future<Map<String, dynamic>?> _latestActivityFuture;

  @override
  void initState() {
    super.initState();
    _latestActivityFuture = _homeController.fetchLatestActivity();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/img/poster1.png',
      'assets/img/poster2.png',
      'assets/img/poster3.png',
      'assets/img/poster4.png',
      'assets/img/poster5.png',
      'assets/img/poster6.png',
    ];

    return Scaffold(
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
                  // Slideshow
                  SlideshowWidget(
                    imagePaths: images,
                    duration: const Duration(seconds: 3),
                  ),

                  const SizedBox(height: 20),

                  // Kiểm tra trạng thái đăng nhập và hiển thị RecentActivity
                  FirebaseAuth.instance.currentUser == null
                      ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Đăng nhập để xem các hoạt động gần đây ',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                      : FutureBuilder<Map<String, dynamic>?>(
                        future: _latestActivityFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Text(
                              'Lỗi tải hoạt động gần đây',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: AppColors.textPrimary,
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return const Text(
                              'Chưa có bài kiểm tra',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: AppColors.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            );
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
                            buttonText: "Xem chi tiết bài kiểm tra",
                            percentage: latestQuiz.completionPercentage,
                            onTap:
                                () => widget.onNavigate(
                                  23,
                                  moduleId: module.moduleId,
                                  quizResultId: latestQuiz.quizResultId,
                                ),
                          );
                        },
                      ),

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
