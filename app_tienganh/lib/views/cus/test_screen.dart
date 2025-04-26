// import 'package:app_tienganh/widgets/line.dart';
// import 'package:flutter/material.dart';
// import 'package:app_tienganh/core/app_colors.dart';
// import 'package:app_tienganh/widgets/navbar.dart';
// import 'package:app_tienganh/widgets/premium_button.dart';
// import 'package:app_tienganh/widgets/number_input_field.dart';
// import 'package:app_tienganh/widgets/toggle.dart';


// class TestScreen extends StatefulWidget {
//   final Function(int) onNavigate;

//   const TestScreen({super.key, required this.onNavigate});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   int currentScreen = 0; // 0: TestSettingScreen 1: TrueFalseTestScreen, 2: MultipleChoiceTestScreen, 3: EssayTestScreen, 4: ResultScreen


//   void switchScreen(int screenIndex) {
//     setState(() {
//       currentScreen = screenIndex;
//     });
//   }

//   @override
//   //khởi tạo trạng thái ban đầu của widget được gọi khi widget được tạo ra lần đầu tiên
//     void initState() {
//       super.initState();
//       // resetPage();
//     }

//   @override
//   //reset widget khi thoát ra và quay lại
//   void didUpdateWidget(covariant TestScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // resetPage();
//   }
  


//   //ĐIỀU CHỈNH MÀN HÌNH HIỂN THỊ

//   @override
//   Widget build(BuildContext context) {
//     Widget body;

//     // Xử lý hiển thị màn hình dựa trên `currentScreen`
//     if (currentScreen == 0) {
//       body = _buildTestSettingScreen();
//     } else if (currentScreen == 1) {
//       body = _buildTrueFalseTestScreen();
//     } else if (currentScreen == 2) {
//       body = _buildMultipleChoiceTestScreen();
//     } else if (currentScreen == 3) {
//       body = _buildEssayTestScreen();
//     } else{
//       body = _buildResultScreen();
//     }

//     return Scaffold(
      
//       //Header
//       appBar: CustomNavBar(
//         title: currentScreen == 0
//             ? "Thiết lập bài kiểm tra"
//             : "Title Course" ,//Tên học phần (sẽ lấy từ database)
                

//         // ICON BÊN TRÁI
//         leadingIconPath: 'assets/img/cross-svgrepo-com.svg' ,
//         onLeadingPressed: () {
//           // Nếu đang ở screen 0 (Course Creation) + hiển thị popup xác nhận
//           if (currentScreen == 0) {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text("Xác nhận"),
//                   content: const Text("Bạn có chắc chắn muốn xóa bài kiểm đã tạo không?"),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Đóng popup
//                       },
//                       child: const Text("Không"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Đóng popup
//                         // resetPage(); // Đặt lại trạng thái
//                         widget.onNavigate(0); // Quay lại trang trước đó
//                       },
//                       child: const Text("Có"),
//                     ),
//                   ],
//                 );
//               },
//             );
//           } else if (currentScreen == 1) {
//             switchScreen(0);
//           } else {
//               switchScreen(1); // Quay lại màn cài đặt (giữa 1, 2 về 0)
//           }
//         },
        
//       ),

//       //Phần thân
//       body: body,
//     );
//   }


//   // Màn hình "TestSettingScreen"

//   bool isTrueFalse = true; // Biến để xác định loại câu hỏi (Đúng/Sai hay Nhiều lựa chọn)
//   bool isMultipleChoice = true; // Biến để xác định loại câu hỏi (Đúng/Sai hay Nhiều lựa chọn)
//   bool isEssay = true; // Biến để xác định loại câu hỏi (Đúng/Sai hay Nhiều lựa chọn)
  
//   Widget _buildTestSettingScreen() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             "Title Course", //Tên học phần (sẽ lấy từ database)
//             style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: AppColors.highlightDarkest,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: EdgeInsets.all(16), // padding đều 4 phía 16px
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Số câu hỏi", //Tên học phần (sẽ lấy từ database)
//                   style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                   ),
//                 ),
//                 SizedBox(width: 40),
//                 Expanded(
//                   child: NumberInputField(
//                     min: 1,
//                     max: 50,
//                     // controller: TextEditingController(), // Thêm controller để quản lý giá trị
//                     // onChanged: (value) {
//                     //   // Xử lý khi giá trị thay đổi
//                     //   print("Số câu hỏi: $value");
//                     // },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Line(),
//           const SizedBox(height: 20),
//           Text(
//             "Hình thức câu hỏi",
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               color: AppColors.highlightDarkest,
//             ),
//           ),
//           const SizedBox(height: 20),

//           Padding(
//             padding: EdgeInsets.all(16), // padding đều 4 phía 16px
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Đúng/Sai", //Tên học phần (sẽ lấy từ database)
//                   style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Toggle(isOn: isTrueFalse),
//               ],
//             ),
//           ),


//           PremiumButton(
//             text: 'Bắt đầu kiểm tra',
//             onTap: () => switchScreen(1), // Chuyển sang câu 1 (cái này tùy vào logic code bài kiểm tra)
//             state: ButtonState.premium, 
//             textColor: AppColors.textPrimary)
//         ],
//       ),
//     );
//   }

//   Widget _buildTrueFalseTestScreen() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               "1/3",// Câu hỏi hiện tại (Sẽ setup từ database)
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.yellow,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
          
//         ],
//       ),
//     );
//   }


//   Widget _buildMultipleChoiceTestScreen() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               "1/3",// Câu hỏi hiện tại (Sẽ setup từ database)
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.yellow,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
          
//         ],
//       ),
//     );
//   }


//   Widget _buildEssayTestScreen() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               "1/3",// Câu hỏi hiện tại (Sẽ setup từ database)
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.yellow,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
          
//         ],
//       ),
//     );
//   }


//   Widget _buildResultScreen() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           const SizedBox(height: 20),
          
//         ],
//       ),
//     );
//   }
// }

