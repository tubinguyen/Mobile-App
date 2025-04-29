import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:app_tienganh/widgets/input_create.dart';
import 'package:app_tienganh/widgets/setting_option.dart';
import 'package:app_tienganh/widgets/select_option.dart';
import 'package:app_tienganh/widgets/navbar.dart';
import 'package:app_tienganh/widgets/premium_button.dart';
import '../../widgets/plus_button.dart';

class CourseCreationScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const CourseCreationScreen({super.key, required this.onNavigate});

  @override
  State<CourseCreationScreen> createState() => _CourseCreationScreenState();
}

class _CourseCreationScreenState extends State<CourseCreationScreen> {
  String? accessSelected; // Trạng thái cho "Ai có thể xem"
  String? updateSelected; // Trạng thái cho "Ai có thể sửa"
  int currentScreen = 0; // 0: CourseCreationScreen 1: CourseCreationSettingScreen, 2: AccessSettingScreen, 3: UpdateSettingScreen


  void switchScreen(int screenIndex) {
    setState(() {
      currentScreen = screenIndex;
    });
  }


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
    const SizedBox(height: 60),
  ];

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

      vocabInputs = [
        InputCreate(label: 'Từ vựng', controller: vocabController),
        const SizedBox(height: 10),
        InputCreate(label: 'Giải nghĩa', controller: meanController),
        const SizedBox(height: 60),
      ];

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



//Cài đặt phương thức của "COURSE CREATION SETTING"
  void resetPageSetting() {
    setState(() {
      accessSelected = null; // Đặt lại trạng thái cho "Ai có thể xem"
      updateSelected = null; // Đặt lại trạng thái cho "Ai có thể sửa"
    });
  }


//ĐIỀU CHỈNH MÀN HÌNH HIỂN THỊ

  @override
  Widget build(BuildContext context) {
    Widget body;

    // Xử lý hiển thị màn hình dựa trên `currentScreen`
    if (currentScreen == 0) {
      body = _buildCourseCreationScreen();
    } else if (currentScreen == 1) {
      body = _buildCourseCreationSettingScreen();
    } else if (currentScreen == 2) {
      body = _buildAccessSettingScreen();
    } else {
      body = _buildUpdateSettingScreen();
    }

    return Scaffold(
      appBar: CustomNavBar(
        title: currentScreen == 0
            ? "Tạo học phần"
            : currentScreen == 1
                ? "Cài đặt học phần"
                : currentScreen == 2
                    ? "Ai có thể xem"
                    : "Cài đặt học sửa",

        // ICON BÊN TRÁI
        leadingIconPath: currentScreen == 0 || currentScreen == 1 ?'assets/img/arrow-prev-svgrepo-com.svg' : '',
        onLeadingPressed: () {
          // Nếu đang ở screen 0 (Course Creation) + hiển thị popup xác nhận
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
                    "Bạn có chắc chắn muốn xóa học phần đã tạo không?",
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
                        widget.onNavigate(0); // Quay lại trang trước đó
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
          } else if (currentScreen == 1) {
            switchScreen(0);
          } else {
              switchScreen(1); // Quay lại màn cài đặt (giữa 1, 2 về 0)
          }
        },
        
        // ICON BÊN PHẢI 
        actionIconPath: 'assets/img/check-svgrepo-com.svg',
        
        onActionPressed: (){
          if (currentScreen == 0){
            switchScreen(1);
          }else if (currentScreen == 1){
            widget.onNavigate(0); //chuyển đến trang học phần của ynhi
            resetPage();
            resetPageSetting(); // Đặt lại trạng thái
            currentScreen = 0; // Đặt lại currentScreen về 0
          } else {
            switchScreen(1); // Quay lại màn hình "Cài đặt học phần"
          }
        }
      ),

      //Phần thân
      body: body,
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
              InputCreate(label: 'Tiêu đề học phần', controller: titleController),
              const SizedBox(height: 10),

              // Mô tả
              if (showShortDescription) ...[
                InputCreate(label: 'Mô tả', controller: descriptionController,),
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
                    textColor: Colors.white,
                  ),
                ),
              ],

              const SizedBox(height: 40),
              
              //Cặp từ vựng và định nghĩa
              ...vocabInputs,
            ],
          ),
        ),
      ),

      //Thêm từ vựng và định nghĩa
      floatingActionButton: PlusButton(
        onPressed: addVocabInput, 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


  // Màn hình "COURSE CREATION SETTING"
  Widget _buildCourseCreationSettingScreen() {
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
              });
            },
          ),
        ],
      ),
    );
  }
}

