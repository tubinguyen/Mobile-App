import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/input_create.dart';
import 'package:app_tienganh/widgets/setting_option.dart';
import 'package:app_tienganh/widgets/select_option.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import '../../widgets/plus_button.dart';

class Vocab {
  final String word;
  final String meaning;

  Vocab({required this.word, required this.meaning});
}

class Course {
  final String title;
  final String description;
  final List<Vocab> vocabList;
  String accessSetting; // Ai có thể xem
  String updateSetting; // Ai có thể sửa

  Course({
    required this.title,
    required this.description,
    required this.vocabList,
    required this.accessSetting,
    required this.updateSetting,
  });
}

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

Course course = Course(
  title: 'Học từ vựng tiếng Anh',
  description: 'Khóa học này giúp bạn học từ vựng tiếng Anh một cách hiệu quả.',
  vocabList: vocabList,
  accessSetting: 'Mọi người',
  updateSetting: 'Chỉ mình tôi',
);

class CourseEditScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const CourseEditScreen({super.key, required this.onNavigate});

  @override
  State<CourseEditScreen> createState() => _CourseEditScreenState();
}

class _CourseEditScreenState extends State<CourseEditScreen> {
  String? accessSelected; // Trạng thái cho "Ai có thể xem"
  String? updateSelected; // Trạng thái cho "Ai có thể sửa"
  int currentScreen = 0; // 0: CourseEditScreen 1: CourseEditSettingScreen, 2: AccessSettingScreen, 3: UpdateSettingScreen


  void switchScreen(int screenIndex) {
    setState(() {
      currentScreen = screenIndex;
    });
  }


  //Cài đặt các biến và phương thức của "COURSE Edit"
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
    const SizedBox(height: 60),
  ];


  @override
  void initState() {
    super.initState();
    resetPage();
  }

  @override
  //reset widget khi thoát ra và quay lại
  void didUpdateWidget(covariant CourseEditScreen oldWidget) {
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

      vocabInputs = [];

      showShortDescription = false;
    });
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
      InputCreate(label: 'Từ vựng', controller: newVocabController),
      const SizedBox(height: 10),
      InputCreate(label: 'Giải nghĩa', controller: newMeanController),
      const SizedBox(height: 60),
    ]);
  });
}



//Cài đặt phương thức của "COURSE Edit SETTING"
  void resetPageSetting() {
    setState(() {
      accessSelected = course.accessSetting; // Đặt lại trạng thái cho "Ai có thể xem"
      updateSelected = course.updateSetting; // Đặt lại trạng thái cho "Ai có thể sửa"
    });
  }


//ĐIỀU CHỈNH MÀN HÌNH HIỂN THỊ

  @override
  Widget build(BuildContext context) {
    Widget body;

    // Xử lý hiển thị màn hình dựa trên `currentScreen`
    if (currentScreen == 0) {
      body = _buildCourseEditScreen();
    } else if (currentScreen == 1) {
      body = _buildCourseEditSettingScreen();
    } else if (currentScreen == 2) {
      body = _buildAccessSettingScreen();
    } else {
      body = _buildUpdateSettingScreen();
    }

    return Scaffold(
      
      //Header
      appBar: CustomNavBar(
        title: currentScreen == 0
            ? "Chỉnh sửa học phần"
            : currentScreen == 1
                ? "Chỉnh sửa cài đặt"
                : currentScreen == 2
                    ? "Ai có thể xem"
                    : "Cài đặt học sửa",

        // ICON BÊN TRÁI
        leadingIconPath: currentScreen == 0 || currentScreen == 1 ?'assets/img/arrow-prev-svgrepo-com.svg' : '',
        onLeadingPressed: () {
          // Nếu đang ở screen 0 (Course Edit) + hiển thị popup xác nhận
          if (currentScreen == 0) {
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
                    "Bạn có chắc chắn hủy chỉnh sửa học phần không? Những thay đổi sẽ không được lưu",
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
                        resetPage(); // Đặt lại trạng thái
                        widget.onNavigate(20); // Quay lại trang học phần
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
          } 

          else if (currentScreen == 1) {
            switchScreen(0);
          } else {
              switchScreen(1); // Quay lại màn cài đặt (giữa 1, 2 về 0)
          }
        },
        
        // ICON BÊN PHẢI 
        actionIconPath: 'assets/img/check-svgrepo-com.svg',
        
        onActionPressed: () {
          if (currentScreen == 0) {
              switchScreen(1);
          } else if (currentScreen == 1) {
            // Kiểm tra nếu một trong hai hoặc cả hai selectedOption trống
            if (accessSelected == null || updateSelected == null) {
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
                      "Vui lòng chọn đầy đủ cả hai tùy chọn 'Ai có thể xem' và 'Ai có thể sửa' trước khi tiếp tục.",
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
              // Nếu hợp lệ, quay lại trang học phần
              widget.onNavigate(12); // Điều hướng đến trang học phần
              resetPage();
              resetPageSetting(); // Đặt lại trạng thái
              currentScreen = 0; // Đặt lại currentScreen về 0
            }
          } else {
            switchScreen(1); // Quay lại màn hình "Cài đặt học phần"
          }
        },
      ),

      //Phần thân
      body: body,
    );
  }


Widget _buildCourseEditScreen() {
  // Gán giá trị ban đầu cho các controller
  titleController.text = course.title;
  descriptionController.text = course.description.isNotEmpty ? course.description : "";

  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề học phần
            InputCreate(label: 'Tiêu đề học phần', controller: titleController),
            const SizedBox(height: 10),

            // Mô tả
            if (course.description.isEmpty && !showShortDescription) ...[
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
              ),
            ] else ...[
              InputCreate(label: 'Mô tả', controller: descriptionController),
              const SizedBox(height: 10),
            ],

            const SizedBox(height: 40),

            // Danh sách từ vựng từ course.vocabList
            ...course.vocabList.map((vocab) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputCreate(label: 'Từ vựng', controller: TextEditingController(text: vocab.word)),
                  const SizedBox(height: 10),
                  InputCreate(label: 'Giải nghĩa', controller: TextEditingController(text: vocab.meaning)),
                  const SizedBox(height: 60),
                ],
              );
            }).toList(),

            // Danh sách từ vựng được thêm
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

  // Màn hình "COURSE Edit SETTING"
  Widget _buildCourseEditSettingScreen() {
    
    // Gán giá trị ban đầu cho các selectedOption
    accessSelected ??= course.accessSetting;
    updateSelected ??= course.updateSetting;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Text(
                'Quyền riêng tư',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.highlightDarkest,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SettingOption(
            options: ["Ai có thể xem", "Ai có thể sửa"],
            pagesIndex: [2, 3], // 2: AccessSettingScreen, 3: UpdateSettingScreen
            selectedOption: [accessSelected, updateSelected],
            onNavigate: (index) {
              switchScreen(index); // Chuyển sang màn hình tương ứng
            },
          ),
        ],
      ),
    );
  }



  // Màn hình "Ai có thể xem"
  Widget _buildAccessSettingScreen() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          SelectOption(
            options: ["Mọi người", "Chỉ mình tôi"],
            onSelect: (option) {
              setState(() {
                accessSelected = option; // Lưu trạng thái
                course.accessSetting = option;
              });
            },
          ),
        ],
      ),
    );
  }



  // Màn hình "Ai có thể sửa"
  Widget _buildUpdateSettingScreen() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          SelectOption(
            options: ["Mọi người", "Chỉ mình tôi"],
            onSelect: (option) {
              setState(() {
                updateSelected = option; // Lưu trạng thái
                course.updateSetting = option;
              });
            },
          ),
        ],
      ),
    );
  }
}

