import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/input_create.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import '../../widgets/plus_button.dart';
import 'package:app_tienganh/services/learning_module_service.dart';
import 'package:app_tienganh/models/learning_module_model.dart';

class CourseCreationScreen extends StatefulWidget {
  final Function(int, {String? moduleId}) onNavigate;

  const CourseCreationScreen({super.key, required this.onNavigate});

  @override
  State<CourseCreationScreen> createState() => _CourseCreationScreenState();
}

class _CourseCreationScreenState extends State<CourseCreationScreen> {
  
  final LearningModuleService _createLearningModuleService = LearningModuleService();

  //Cài đặt các biến và phương thức của "COURSE CREATION"
  List<Widget> vocabInputs = [];
  bool showShortDescription = false;
  
  //Để reset lại các trường nhập liệu
  TextEditingController titleController = TextEditingController();
  TextEditingController vocabController = TextEditingController();
  TextEditingController meanController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<Map<String, TextEditingController>> vocabControllers = [];

  List<Widget> get initialVocabInputs => [
    InputCreate(label: 'Từ vựng', controller: vocabController),
    const SizedBox(height: 10),
    InputCreate(label: 'Giải nghĩa',controller: meanController),
    const SizedBox(height: 50),
  ];

void _handeCreateLearningModule() async {
  try {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final vocabList = vocabControllers.map((item) {
      final vocabText = item['vocab']?.text.trim() ?? '';
      final meanText = item['mean']?.text.trim() ?? '';

      if (vocabText.isEmpty || meanText.isEmpty) {
        throw Exception("Từ vựng hoặc giải nghĩa không được để trống.");
      }

      return VocabularyItem(
        word: vocabText,
        meaning: meanText,
      );
    }).toList();

    if (title.isEmpty) {
      throw Exception("Tiêu đề không được để trống.");
    }

    // Gọi hàm tạo học phần và nhận moduleId
    final result = await _createLearningModuleService.createLearningModule(
      moduleName: title,
      description: description.isEmpty ? null : description,
      vocabulary: vocabList,
    );

    if (result == "Người dùng chưa đăng nhập.") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            title: Text(
              "Chưa đăng nhập",
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            content: Text(
              "Bạn chưa đăng nhập?",
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
                  resetPage(); // Đặt lại trạng thái
                  widget.onNavigate(6); // Chuyển hướng đến trang đăng nhập
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
      return;
    }

    if (result != "Đã có lỗi xảy ra.") {
      // Hiển thị thông báo thành công
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            title: Text(
              "Thành công",
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            content: const Text(
              "Học phần đã được tạo thành công!",
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.textPrimary,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng popup
                  widget.onNavigate(12, moduleId: result); // Điều hướng đến trang học phần với moduleId
                  resetPage(); // Đặt lại trạng thái
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
    }
  } catch (e) {
    // Hiển thị thông báo lỗi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: Text(
            "Lỗi",
            style: const TextStyle(
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

  void addVocabInput() {
    final newVocabController = TextEditingController();
    final newMeanController = TextEditingController();

    vocabControllers.add({
      'vocab': newVocabController,
      'mean': newMeanController,
    });

    setState(() {
      vocabInputs.addAll([
        InputCreate(
          label: 'Từ vựng',
          controller: newVocabController,
        ),
        const SizedBox(height: 10),
        InputCreate(
          label: 'Giải nghĩa',
          controller: newMeanController,
        ),
        const SizedBox(height: 60),
      ]);
    });
  }

  

//ĐIỀU CHỈNH MÀN HÌNH HIỂN THỊ

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      //Header
      appBar: CustomNavBar(
        title:  "Tạo học phần",

        // ICON BÊN TRÁI
        leadingIconPath: 'assets/img/back.svg',
        onLeadingPressed: () {
          // Nếu đang ở screen 0 (Course Creation) + hiển thị popup xác nhận
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
                  "Bạn có chắc chắn muốn xóa học phần đã tạo không?",
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
                      resetPage(); // Đặt lại trạng thái
                      widget.onNavigate(0); // Quay lại trang trước đó
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
      
        // ICON BÊN PHẢI 
        actionIconPath: 'assets/img/check-svgrepo-com.svg',
        
        onActionPressed: () {
            // Kiểm tra nếu tiêu đề hoặc cặp từ vựng đầu tiên trống
            if (titleController.text.trim().isEmpty ||
                vocabController.text.trim().isEmpty ||
                meanController.text.trim().isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white, // Nền màu trắng
                    title: Text(
                      "Lỗi",
                      style: const TextStyle(
                        fontFamily: 'Montserrat', 
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary, 
                      ),
                    ),
                    content: Text(
                      "Vui lòng điền đầy đủ tiêu đề và cặp từ vựng đầu tiên trước khi tiếp tục.",
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
            } else {
              _handeCreateLearningModule(); // Gọi hàm tạo học phần
            }
          
        },
      ),

      //Phần thân
      body: _buildCourseCreationScreen(),
    );
  }


  //Màn hình "COURSE CREATION"
  Widget _buildCourseCreationScreen() {
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

              // Mô tả
              if (showShortDescription) ...[
                InputCreate(
                  label: 'Mô tả',
                  controller: descriptionController,
                ),
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

              // Danh sách từ vựng
              ...vocabInputs,
            ],
          ),
        ),
      ),

      // Thêm từ vựng và định nghĩa
      floatingActionButton: PlusButton(
        onPressed: addVocabInput,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


  @override
  //khởi tạo trạng thái ban đầu của widget được gọi khi widget được tạo ra lần đầu tiên
    void initState() {
      super.initState();
      resetPage();
    }

  @override
  //reset widget khi thoát ra và quay lại
  void didUpdateWidget(covariant CourseCreationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    resetPage();
  }

  void resetPage() {
    setState(() {
      titleController.clear();
      vocabController.clear();
      meanController.clear();
      vocabControllers.clear();
      descriptionController.clear();

      // Thêm mục mặc định vào vocabControllers
      vocabControllers.add({
        'vocab': vocabController,
        'mean': meanController,
      });

      vocabInputs = [
        InputCreate(label: 'Từ vựng', controller: vocabController),
        const SizedBox(height: 10),
        InputCreate(label: 'Giải nghĩa', controller: meanController),
        const SizedBox(height: 60),
      ];

      showShortDescription = false;
    });
  }
}