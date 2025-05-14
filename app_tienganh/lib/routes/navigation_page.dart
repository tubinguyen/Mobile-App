import 'package:flutter/material.dart';
import '../views/cus/home_screen.dart';
import '../views/cus/library_screen.dart';
import '../views/cus/login_screen.dart';
import '../views/cus/forget_password_screen.dart';
import '../views/cus/course_creation_screen.dart';
import '../views/cus/register_screen.dart';
import '../views/admin/user_management.dart';
import '../views/admin/product_management.dart';
import '../views/admin/order_management.dart';
import '../views/admin/add_product_screen.dart';
import '../views/admin/edit_product_screen.dart';
import '../views/cus/store_screen.dart';
import '../views/cus/profile_screen.dart';
import '../views/cus/notification_screen.dart';
import '../views/cus/study_session_screen.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/header.dart';
import '../views/cus/test_screen.dart';
import '../views/cus/flashcard_screen.dart';
import '../views/cus/order_screen.dart';
import '../views/cus/update_profile_screen.dart';
import '../views/cus/update_password_screen.dart';
import '../views/admin/account_management_screen.dart';
import '../views/admin/edit_account_screen.dart';
import '../views/cus/course_edit_screen.dart';
import '../services/auth_service.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;


  final Set<int> _pagesWithHeader = {0, 1, 3, 4, 5, 12, 14, 16, 18, 19};
  final Set<int> _pagesWithBottomNavigationBar = {0, 1, 2, 3, 4};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen(onNavigate: _onItemTapped);
      case 1:
        return LibraryScreen(onNavigate: _onItemTapped);
      case 2:
        return CourseCreationScreen(onNavigate: _onItemTapped);
      case 3:
        return StoreScreen(onNavigate: _onItemTapped);
      case 4:
        return ProfileScreen(onNavigate: _onItemTapped);
      case 5:
        return NotificationScreen(onNavigate: _onItemTapped);
      case 6:
        return LoginScreen(onNavigate: _onItemTapped);
      case 7:
        return ForgetPasswordScreen(onNavigate: _onItemTapped);
      case 8:
        return RegisterScreen(onNavigate: _onItemTapped);
      case 9:
        return UserManagement(onNavigate: _onItemTapped);
      case 10:
        return ProductManagement(onNavigate: _onItemTapped);
      case 11:
        return OrderManagement(onNavigate: _onItemTapped);
      case 12:
        return StudySessionPage(onNavigate: _onItemTapped);
      case 13:
        return AddProduct(onNavigate: _onItemTapped);
      case 14:
        return EditProduct(onNavigate: _onItemTapped);
      case 15:
        return TestScreen(onNavigate: _onItemTapped);
      case 16:
        return FlashcardScreen(onNavigate: _onItemTapped);
      case 17:
        return OrderScreen(onNavigate: _onItemTapped);
      case 18:
        return UpdateProfileScreen(onNavigate: _onItemTapped);
      case 19:
        return UpdatePasswordScreen(onNavigate: _onItemTapped);
      case 20:
        return StudySessionPage(onNavigate: _onItemTapped);
      case 21:
        return AccountManagement(onNavigate: _onItemTapped);
      case 22:
        return EditAccountScreen(
          onNavigate: _onItemTapped,
          initialName: 'Tên mẫu',
          initialEmail: 'email@example.com',
          initialAddress: 'Địa chỉ mẫu',
          initialPhone: '0123456789',
        );
      case 23:
        return CourseEditScreen(onNavigate: _onItemTapped);
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          _pagesWithHeader.contains(_selectedIndex)
              ? Header(
                onHomeTap: () => _onItemTapped(0),
                onNotificationTap: () => _onItemTapped(5),
                onAuthTap: () => _onItemTapped(6),
                onAccountTap:  () => _onItemTapped(4),
                onLogoutTap: () async {
                  String message = await AuthService().signOut();
                  if (message == "Đăng xuất thành công!") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                    _onItemTapped(0); 
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  }
                },
              )
              : null,
      body: _getPage(_selectedIndex),
      bottomNavigationBar:
          _pagesWithBottomNavigationBar.contains(_selectedIndex)
              ? CustomBottomNavigationBar(
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
              )
              : null,
    );
  }
}
