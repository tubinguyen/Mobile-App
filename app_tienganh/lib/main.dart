import 'package:flutter/material.dart';
import 'routes/navigation_page.dart'; // Import màn hình chính

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const NavigationPage(),
    );
  }
}
