import 'package:flutter/material.dart';
import '../views/cus/home_screen.dart';
import '../views/cus/review_screen.dart';
import '../views/cus/login_screen.dart';
import '../views/cus/course_creation_screen.dart';
import '../views/cus/store_screen.dart';
import '../views/cus/profile_screen.dart';
import '../views/cus/notification_screen.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/header.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeScreen(onNavigate: _onItemTapped), 
      ReviewScreen(onNavigate:_onItemTapped),
      CourseCreationScreen(onNavigate:_onItemTapped),
      StoreScreen(onNavigate:_onItemTapped),
      NotificationScreen(onNavigate:_onItemTapped),
      ProfileScreen(onNavigate:_onItemTapped),
      LoginScreen(onNavigate:_onItemTapped),
    ]);
  }

  final Set<int> _pagesWithHeader = {0, 1, 3, 4, 5};
  final Set<int> _pagesWithBottomNavigationBar = {0, 1, 3, 4, 5};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pagesWithHeader.contains(_selectedIndex)
          ? Header(
              onHomeTap: () => _onItemTapped(0),
              onNotificationTap: () => _onItemTapped(4),
              onAuthTap: () => _onItemTapped(6),
            )
          : null,
      body:  
      IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _pagesWithBottomNavigationBar.contains(_selectedIndex)
          ? CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            )
          : null,
    );
  }
}
