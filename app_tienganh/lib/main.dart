import 'package:app_tienganh/widgets/setting_option.dart';
import 'package:app_tienganh/widgets/setting_study_section.dart';
import 'package:flutter/material.dart';
import 'core/app_colors.dart';
import 'views/test.dart';
// import 'widgets/large_button.dart';
// import 'widgets/recent_activity.dart';
// import 'widgets/percent.dart';
// import 'widgets/content_switch.dart';
import 'widgets/function.dart';
// import 'widgets/select_option.dart';
// import 'widgets/setting_option.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // LargeButton(
              //   text: "Go to Page",
              //   destination: TestPage(),
              // ),

                SizedBox(height: 10.0,),
            FunctionCard(
              icon: Icons.quiz, // Icon tuỳ chỉnh
              text: "Thẻ ghi nhớ", // Văn bản tuỳ chỉnh
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestPage()), // Chuyển đến trang ...
              );
            },
            ),
            // SettingOption(
            //   options: ["Trang A", "Trang B"],
            //   pages: [TestPage(), TestPage(), TestPage()], // Danh sách các trang tương ứng
            //   onTap: (option) {
            //     // print("Bạn đã chọn: $option");
            //   },
            // ),
            // IconButton(
            //   icon: Icon(Icons.settings),
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return AlertDialog(
            //           content: SettingStudySection(),
            //         );
            //       },
            //     );
            //   },
            // ),
            SettingStudySection(),

            ],
          ),
        ),
      ),
    );
  }
}
