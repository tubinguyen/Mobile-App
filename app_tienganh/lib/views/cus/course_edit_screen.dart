import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/input_create.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import '../../widgets/plus_button.dart';
import 'package:app_tienganh/controllers/learning_module_controller.dart';
import 'package:app_tienganh/controllers/notification_controller.dart';
import 'package:app_tienganh/models/learning_module_model.dart';

class CourseEditScreen extends StatefulWidget {
  final String moduleId;
  final Function(int, {String? moduleId}) onNavigate;

  const CourseEditScreen({
    super.key,
    required this.moduleId,
    required this.onNavigate,
  });

  @override
  State<CourseEditScreen> createState() => _CourseEditScreenState();
}

class _CourseEditScreenState extends State<CourseEditScreen> {
  final LearningModuleController _learningModuleController =
      LearningModuleController();
  final NotificationController _notificationController =
      NotificationController();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Map<String, TextEditingController>> vocabControllers = [];
  List<Widget> vocabInputs = [];
  bool showShortDescription = false;

  @override
  void initState() {
    super.initState();
    _loadLearningModule();
  }

  Future<void> _handleUpdateLearningModule() async {
    try {
      final title = titleController.text.trim();
      final description =
          descriptionController.text.trim().isEmpty
              ? null
              : descriptionController.text.trim();

      final vocabList =
          vocabControllers
              .map((item) {
                final vocabText = item['vocab']?.text.trim() ?? '';
                final meanText = item['mean']?.text.trim() ?? '';

                if (vocabText.isEmpty || meanText.isEmpty) {
                  return null;
                }

                return VocabularyItem(word: vocabText, meaning: meanText);
              })
              .where((item) => item != null)
              .cast<VocabularyItem>()
              .toList();

      if (title.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.background,
              title: const Text(
                "Lỗi",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              content: const Text(
                "Tiêu đề học phần không được để trống.",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: AppColors.textPrimary,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onNavigate(12, moduleId: widget.moduleId);
                  },
                  child: const Text(
                    "OK",
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
        // return;
      }

      if (vocabList.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.background,
              title: const Text(
                "Lỗi",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              content: const Text(
                "Học phần phải có ít nhất một cặp từ vựng.",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: AppColors.textPrimary,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onNavigate(12, moduleId: widget.moduleId);
                  },
                  child: const Text(
                    "OK",
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
        return;
      }

      // Cập nhật học phần
      await _learningModuleController.updateLearningModule(
        moduleId: widget.moduleId,
        moduleName: title,
        description: description,
        vocabulary: vocabList,
      );

      // Tạo thông báo khi học phần được chỉnh sửa thành công
      await _notificationController.createModuleEditNotification(
        userId: FirebaseAuth.instance.currentUser!.uid,
        moduleId: widget.moduleId,
        moduleName: title,
      );

      setState(() {
        showShortDescription = description != null;
      });

      // Hiển thị thông báo thành công
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            title: const Text(
              "Thành công",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            content: const Text(
              "Học phần đã được cập nhật thành công!",
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.textPrimary,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onNavigate(12, moduleId: widget.moduleId);
                },
                child: const Text(
                  "Xem học phần",
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
    } catch (e) {
      // Hiển thị thông báo lỗi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            title: const Text(
              "Lỗi",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            content: Text(
              e.toString(),
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
                  "OK",
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
    }
  }

  void addVocabInput() async {
    final newVocabController = TextEditingController();
    final newMeanController = TextEditingController();

    vocabControllers.add({
      'vocab': newVocabController,
      'mean': newMeanController,
    });

    setState(() {
      vocabInputs.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputCreate(label: 'Từ vựng', controller: newVocabController),
            const SizedBox(height: 10),
            InputCreate(label: 'Giải nghĩa', controller: newMeanController),
            const SizedBox(height: 60),
          ],
        ),
      );
    });

    // Cập nhật Firebase ngay khi thêm từ vựng
    try {
      final vocabList =
          vocabControllers
              .map((item) {
                final vocabText = item['vocab']?.text.trim() ?? '';
                final meanText = item['mean']?.text.trim() ?? '';

                if (vocabText.isEmpty || meanText.isEmpty) {
                  return null;
                }

                return VocabularyItem(word: vocabText, meaning: meanText);
              })
              .where((item) => item != null)
              .cast<VocabularyItem>()
              .toList();

      await _learningModuleController.updateLearningModule(
        moduleId: widget.moduleId,
        moduleName: titleController.text.trim(),
        description:
            descriptionController.text.trim().isEmpty
                ? null
                : descriptionController.text.trim(),
        vocabulary: vocabList,
      );
    } catch (e) {
      print("Error updating vocabulary: $e");
    }
  }

  Future<void> _loadLearningModule() async {
    final learningModule = await _learningModuleController
        .getLearningModuleById(widget.moduleId);

    if (learningModule != null) {
      setState(() {
        titleController.text = learningModule.moduleName;
        descriptionController.text = learningModule.description ?? '';
        showShortDescription = learningModule.description != null;

        vocabControllers =
            learningModule.vocabulary.map((vocab) {
              return {
                'vocab': TextEditingController(text: vocab.word),
                'mean': TextEditingController(text: vocab.meaning),
              };
            }).toList();

        vocabInputs =
            vocabControllers.map((controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputCreate(
                    label: 'Từ vựng',
                    controller: controller['vocab']!,
                  ),
                  const SizedBox(height: 10),
                  InputCreate(
                    label: 'Giải nghĩa',
                    controller: controller['mean']!,
                  ),
                  const SizedBox(height: 60),
                ],
              );
            }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Chỉnh sửa học phần',
        leadingIconPath: 'assets/img/arrow-prev-svgrepo-com.svg',
        onLeadingPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppColors.background,
                title: const Text(
                  "Xác nhận",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                content: const Text(
                  "Bạn có chắc chắn hủy chỉnh sửa học phần không? Những thay đổi sẽ không được lưu.",
                  style: TextStyle(
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
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onNavigate(12, moduleId: widget.moduleId);
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
        actionIconPath: 'assets/img/check-svgrepo-com.svg',
        onActionPressed: _handleUpdateLearningModule,
      ),
      body: _buildCourseEditScreen(),
    );
  }

  Widget _buildCourseEditScreen() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputCreate(
                label: 'Tiêu đề học phần',
                controller: titleController,
              ),
              const SizedBox(height: 10),
              if (showShortDescription) ...[
                InputCreate(label: 'Mô tả', controller: descriptionController),
                const SizedBox(height: 10),
              ] else ...[
                Align(
                  alignment: Alignment.centerRight,
                  child: PremiumButton(
                    text: '+ Mô tả',
                    onTap: () {
                      setState(() {
                        showShortDescription = true;
                      });
                    },
                    state: ButtonState.premium,
                    textColor: AppColors.background,
                  ),
                ),
              ],
              const SizedBox(height: 40),
              ...vocabInputs,
            ],
          ),
        ),
      ),
      floatingActionButton: PlusButton(onPressed: addVocabInput),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
