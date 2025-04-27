import 'package:app_tienganh/views/cus/order_screen.dart';
import 'package:flutter/material.dart';
import '../views/cus/home_screen.dart';
import '../views/cus/library_screen.dart';
import '../views/cus/login_screen.dart';
import '../views/cus/course_creation_screen.dart';
import '../views/admin/user_management.dart';
import '../views/admin/product_management.dart';
import '../views/admin/order_management.dart';
import '../views/admin/account_management.dart';
import '../views/cus/store_screen.dart';
import '../views/cus/profile_screen.dart';
import '../views/cus/notification_screen.dart';
import '../views/cus/study_session_screen.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/header.dart';
import '../views/cus/order_screen.dart';
import '../views/cus/update_profile_screen.dart';
import '../views/cus/update_password_screen.dart';

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
      LibraryScreen(onNavigate:_onItemTapped),
      CourseCreationScreen(onNavigate:_onItemTapped),
      StoreScreen(onNavigate:_onItemTapped),
      ProfileScreen(onNavigate:_onItemTapped),
      NotificationScreen(onNavigate:_onItemTapped),
      LoginScreen(onNavigate:_onItemTapped),
      UserManagement(onNavigate:_onItemTapped),
      ProductManagement(onNavigate:_onItemTapped),
      OrderManagement(onNavigate:_onItemTapped),
      AccountManagement(onNavigate:_onItemTapped),
      StudySessionPage(onNavigate:_onItemTapped),
      OrderScreen(onNavigate: _onItemTapped),
      UpdateProfileScreen(onNavigate: _onItemTapped), //13: update profile
      UpdatePasswordScreen(onNavigate: _onItemTapped) //14: Update pass
    ]);
  }

  final Set<int> _pagesWithHeader = {0, 1, 3, 4, 5,11,12,13,14};
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
