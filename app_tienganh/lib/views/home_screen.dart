import 'package:flutter/material.dart';
// import '../widgets/google_button.dart';
import '../widgets/filter.dart';
class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Text(
            //   'Nội dung Trang chủ',
            //   style: TextStyle(fontSize: 24),
            // ),
            // const SizedBox(height: 20), 
            // GoogleSignInButton(
            //   onTap: () {
            //     onNavigate(4); 
            //   },
            // ),
            // const SizedBox(height: 20),
            Filter(
              options: ['Lọc theo Ngày', 'Lọc theo Tháng', 'Lọc theo Năm'],
              onSelected: (String value) {
                // Handle filter selection
                print('Selected filter: $value');
              },
            ),
            
          ],
        ),
      ),
    );
  }
}