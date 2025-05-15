import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import '../../widgets/navbar.dart';
import '../../widgets/list_card.dart';
import '../../widgets/avatarname.dart';
import '../../widgets/function_card.dart';
import '../../widgets/voca.dart';
import 'package:app_tienganh/services/learning_module_service.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/user_model.dart';

class StudySessionPage extends StatefulWidget {
  final String moduleId; 
  final Function(int, {String? moduleId}) onNavigate;

  const StudySessionPage({
    super.key,
    required this.moduleId,
    required this.onNavigate,
  });

  @override
  State<StudySessionPage> createState() => _StudySessionPageState();
}

class _StudySessionPageState extends State<StudySessionPage> {
  final LearningModuleService _getLearningModuleService = LearningModuleService();

  late Future<LearningModuleModel?> _learningModuleFuture;
  late Future<UserModel?> _userFuture;
  late Function(String) _deleteLearningModule;

  @override
  void initState() {
    super.initState();
    if (widget.moduleId.isEmpty) {
      print("Error: moduleId is empty");
      return;
    }
    _learningModuleFuture = _getLearningModuleService.getLearningModuleById(widget.moduleId);
    _userFuture = _getLearningModuleService.getUserInfo();
    _deleteLearningModule = _getLearningModuleService.deleteLearningModule;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: "Học phần của bạn",
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () {
          widget.onNavigate(1);
        },
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([_learningModuleFuture, _userFuture]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Đã xảy ra lỗi khi tải dữ liệu.",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }

            final learningModule = snapshot.data?[0] as LearningModuleModel?;
            final userInfo = snapshot.data?[1] as UserModel?;

            if (learningModule == null || userInfo == null) {
              return Center(
                child: Text(
                  "Không tìm thấy dữ liệu.",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }

            final vocabularyList = learningModule.vocabulary.map((vocab) {
              return {
                'word': vocab.word,
                'meaning': vocab.meaning,
              };
            }).toList();


            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Column(
                  children: [
                    ListCard(vocabularyList: vocabularyList),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Text(
                                learningModule.moduleName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.highlightDarkest,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              const Spacer(),

                              PopupMenuButton<String>(
                                icon: const Icon(
                                  Icons.more_horiz,
                                  size: 20,
                                  color: AppColors.textPrimary,
                                ),
                                offset: const Offset(0, 40), // Điều chỉnh vị trí menu
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Bo góc menu
                                ),
                                color: AppColors.background, // Màu nền menu
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Row(
                                      children: const [
                                        Icon(Icons.edit, size: 18, color: AppColors.highlightDarkest),
                                        SizedBox(width: 8),
                                        Text(
                                          "Sửa học phần",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            color: AppColors.highlightDarkest,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete, size: 18, color: AppColors.red),
                                        SizedBox(width: 8),
                                        Text(
                                          "Xóa học phần",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            color: AppColors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (String value) {
                                  if (value == 'edit') {
                                    widget.onNavigate(22, moduleId: learningModule.moduleId); // Điều hướng đến màn hình sửa học phần
                                  } else if (value == 'delete') {
                                    // Xử lý xóa học phần
                                    _handleDeleteLearningModule(context, learningModule.moduleId);
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              AvatarName(
                                username: userInfo.username,
                                avatarUrl: userInfo.avatarUrl,
                              ),
                              const Spacer(),
                              VerticalDivider(
                                thickness: 2,
                                width: 20,
                                color: AppColors.highlightDarkest,
                              ),
                              const Spacer(),
                              Text(
                                '${learningModule.totalWords} từ vựng',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            learningModule.description ?? 'Mô tả',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 16),
                          FunctionCard(
                            icon: Icons.edit_note,
                            text: 'Thẻ ghi nhớ',
                            onTap: () {
                              widget.onNavigate(16);
                            },
                          ),
                          FunctionCard(
                            icon: Icons.task_sharp,
                            text: 'Kiểm tra',
                            onTap: () {
                              widget.onNavigate(15, moduleId: learningModule.moduleId);
                            },
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Từ vựng',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: vocabularyList
                                .map(
                                  (word) => Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Voca(label: word['word']!),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleDeleteLearningModule(BuildContext context, String moduleId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.background,
        title: const Text(
          "Xác nhận xóa",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: const Text(
          "Bạn có chắc chắn muốn xóa học phần này không?",
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng popup
            },
            child: const Text(
              "Hủy",
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.textPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng popup
              _deleteLearningModule(moduleId); // Thực hiện xóa học phần
              widget.onNavigate(1); 
            },
            child: const Text(
              "Xóa",
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}

}