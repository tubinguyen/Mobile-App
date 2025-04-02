import 'package:flutter/material.dart';
import 'dart:async';

class SlideshowWidget extends StatefulWidget {
  final List<String> imagePaths; 
  final Duration duration;

  const SlideshowWidget({
    super.key,
    required this.imagePaths,
    this.duration = const Duration(seconds: 3),
  });

  @override
  SlideshowWidgetState createState() => SlideshowWidgetState();
}

class SlideshowWidgetState extends State<SlideshowWidget> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startSlideshow();
  }

  void _startSlideshow() {
    _timer = Timer.periodic(widget.duration, (timer) {
      if (mounted) {
        setState(() {
          _currentPage = (_currentPage + 1) % widget.imagePaths.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 412,
      height: 214,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.imagePaths.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return Image.asset(
            widget.imagePaths[index], 
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

//Cach sư dung
// Gọi final List<String> images = [
    //   'assets/img/user.jpg',
    //   'assets/img/user.jpg',
    //   'assets/img/user.jpg',
    // ];
    // SlideshowWidget(
    //           imagePaths: images, 
    //           duration: Duration(seconds: 3),
    //         ),