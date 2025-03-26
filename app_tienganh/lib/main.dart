import 'package:flutter/material.dart';
import 'core/app_colors.dart';
// import 'views/test.dart';
// import 'widgets/large_button.dart';

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

            ],
          ),
        ),
      ),
    );
  }
}