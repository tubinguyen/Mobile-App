import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/input_create.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import '../../widgets/plus_button.dart';
import 'package:app_tienganh/services/learning_module_service.dart';
import 'package:app_tienganh/models/learning_module_model.dart';
import 'package:app_tienganh/models/user_model.dart';

// class Vocab {
//   final String word;
//   final String meaning;

//   Vocab({required this.word, required this.meaning});
// }

// class Course {
//   final String title;
//   final String description;
//   final List<Vocab> vocabList;


//   Course({
//     required this.title,
//     required this.description,
//     required this.vocabList,
//   });
// }

// List<Vocab> vocabList = [
//   Vocab(word: 'Apple', meaning: 'Quả táo'),
//   Vocab(word: 'Dog', meaning: 'Con chó'),
//   Vocab(word: 'Sun', meaning: 'Mặt trời'),
//   Vocab(word: 'Book', meaning: 'Cuốn sách'),
//   Vocab(word: 'Chair', meaning: 'Cái ghế'),
//   Vocab(word: 'Water', meaning: 'Nước'),
//   Vocab(word: 'Phone', meaning: 'Điện thoại'),
//   Vocab(word: 'Tree', meaning: 'Cái cây'),
// ];

// Course course = Course(
//   title: 'Học từ vựng tiếng Anh',
//   description: 'Khóa học này giúp bạn học từ vựng tiếng Anh một cách hiệu quả.',
//   vocabList: vocabList,
// );

class CourseEditScreen extends StatefulWidget {
  final String moduleId;
  final Function(int, {String? moduleId}) onNavigate;

  const CourseEditScreen({super.key, required this.moduleId, required this.onNavigate});

  @override
  State<CourseEditScreen> createState() => _CourseEditScreenState();
}

class _CourseEditScreenState extends State<CourseEditScreen> {
  final LearningModuleService _learningModuleService = LearningModuleService();

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

  // Future<void> _loadLearningModule() async {
  //   final learningModule = await _learningModuleService.getLearningModuleById(widget.moduleId);

  //   if (learningModule != null) {
  //     setState(() {
  //       titleController.text = learningModule.moduleName;
  //       descriptionController.text = learningModule.description ?? '';
  //       learningModule.description != null 
  //           ? showShortDescription = true
  //           : showShortDescription = false;

  //       vocabControllers = learningModule.vocabulary.map((vocab) {
  //         return {
  //           'vocab': TextEditingController(text: vocab.word),
  //           'mean': TextEditingController(text: vocab.meaning),
  //         };
  //       }).toList();

  //       vocabInputs = vocabControllers.map((controller) {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             InputCreate(label: 'Từ vựng', controller: controller['vocab']!),
  //             const SizedBox(height: 10),
  //             InputCreate(label: 'Giải nghĩa', controller: controller['mean']!),
  //             const SizedBox(height: 60),
  //           ],
  //         );
  //       }).toList();
  //     });
  //   }
  // }

  // void addVocabInput() {
  //   final newVocabController = TextEditingController();
  //   final newMeanController = TextEditingController();

  //   vocabControllers.add({
  //     'vocab': newVocabController,
  //     'mean': newMeanController,
  //   });

  //   setState(() {
  //     vocabInputs.addAll([
  //       InputCreate(label: 'Từ vựng', controller: newVocabController),
  //       const SizedBox(height: 10),
  //       InputCreate(label: 'Giải nghĩa', controller: newMeanController),
  //       const SizedBox(height: 60),
  //     ]);
  //   });
  // }

  Future<void> _handleUpdateLearningModule() async {
    try {
      final title = titleController.text.trim();
      final description = descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim();

      final vocabList = vocabControllers.map((item) {
        final vocabText = item['vocab']?.text.trim() ?? '';
        final meanText = item['mean']?.text.trim() ?? '';

        if (vocabText.isEmpty || meanText.isEmpty) {
          return null; // Bỏ qua cặp từ trống
        }

        return VocabularyItem(word: vocabText, meaning: meanText);
      }).where((item) => item != null).cast<VocabularyItem>().toList();

      if (title.isEmpty) {
        throw Exception("Tiêu đề học phần không được để trống.");
      }

      if (vocabList.isEmpty) {
        throw Exception("Học phần phải có ít nhất một cặp từ vựng.");
      }

      // Gọi hàm cập nhật học phần
      await _learningModuleService.updateLearningModule(
        moduleId: widget.moduleId,
        moduleName: title,
        description: description,
        vocabulary: vocabList,
      );

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
                  Navigator.of(context).pop(); // Đóng popup
                  widget.onNavigate(12, moduleId: widget.moduleId); // Điều hướng đến trang học phần
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
                  Navigator.of(context).pop(); // Đóng popup
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
    vocabInputs.addAll([
      InputCreate(label: 'Từ vựng', controller: newVocabController),
      const SizedBox(height: 10),
      InputCreate(label: 'Giải nghĩa', controller: newMeanController),
      const SizedBox(height: 60),
    ]);
  });

  // Cập nhật Firebase ngay khi thêm từ vựng
  try {
    final vocabList = vocabControllers.map((item) {
      final vocabText = item['vocab']?.text.trim() ?? '';
      final meanText = item['mean']?.text.trim() ?? '';

      if (vocabText.isEmpty || meanText.isEmpty) {
        return null; // Bỏ qua cặp từ trống
      }

      return VocabularyItem(word: vocabText, meaning: meanText);
    }).where((item) => item != null).cast<VocabularyItem>().toList();

    await _learningModuleService.updateLearningModule(
      moduleId: widget.moduleId,
      moduleName: titleController.text.trim(),
      description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
      vocabulary: vocabList,
    );
  } catch (e) {
    print("Error updating vocabulary: $e");
  }
}

Future<void> _loadLearningModule() async {
  final learningModule = await _learningModuleService.getLearningModuleById(widget.moduleId);

  if (learningModule != null) {
    setState(() {
      titleController.text = learningModule.moduleName;
      descriptionController.text = learningModule.description ?? '';
      showShortDescription = learningModule.description != null;

      vocabControllers = learningModule.vocabulary.map((vocab) {
        return {
          'vocab': TextEditingController(text: vocab.word),
          'mean': TextEditingController(text: vocab.meaning),
        };
      }).toList();

      vocabInputs = vocabControllers.map((controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputCreate(label: 'Từ vựng', controller: controller['vocab']!),
            const SizedBox(height: 10),
            InputCreate(label: 'Giải nghĩa', controller: controller['mean']!),
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
                      Navigator.of(context).pop(); // Đóng popup
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
                      Navigator.of(context).pop(); // Đóng popup
                      widget.onNavigate(12, moduleId: widget.moduleId); // Quay lại trang học phần
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
      floatingActionButton: PlusButton(onPressed: addVocabInput),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCourseEditScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputCreate(label: 'Tiêu đề học phần', controller: titleController),
          const SizedBox(height: 10),
          if (!showShortDescription)
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
                textColor: Colors.white,
              ),
            )
          else
            InputCreate(label: 'Mô tả', controller: descriptionController),
          const SizedBox(height: 40),
          ...vocabInputs,
        ],
      ),
    );
    
  }
}



 


