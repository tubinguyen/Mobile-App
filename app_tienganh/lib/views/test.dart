import 'package:flutter/material.dart';
class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hello")),
      body: Center(child: Text("Welcome to Page!")),
    );
  }
}