import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const NotificationScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Thông báo',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}
