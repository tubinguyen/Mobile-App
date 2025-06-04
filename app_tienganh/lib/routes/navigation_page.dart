import 'package:app_tienganh/views/cus/test_result_screen.dart';
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
import '../views/cus/course_edit_screen.dart';
import '../controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final Set<int> _pagesWithHeader = {
    0, 1, 2, 3, 4, 5, 12, 14, 15, 16, 18, 19, 23,
  };
  final Set<int> _pagesWithBottomNavigationBar = {0, 1, 2, 3, 4};

  String? _currentModuleId;
  String? _currentQuizResultId;

  @override
  void initState() {
    super.initState();
     _selectedIndex = 0; // mặc định là user thường
    _loadUserRoleAndNavigate();
  }

  Future<void> _loadUserRoleAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      await prefs.remove('user_role');
    }

    String? role = prefs.getString('user_role');

    if (role == null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists && doc.data()!.containsKey('role')) {
          role = doc.get('role').toString();
          await prefs.setString('user_role', role);
        } else {
          role = '0';
        }
      } else {
        role = '0';
      }
    }

    setState(() {
      _selectedIndex = (role == '1') ? 9 : 0;
      print("Current user role: $role");
      print("Selected index: $_selectedIndex");
    });
  }

  void _onItemTapped(int index, {String? moduleId, String? quizResultId}) {
    setState(() {
      _selectedIndex = index;
      _currentModuleId = moduleId;
      _currentQuizResultId = quizResultId;
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
        return NotificationScreen(onNavigate: _onItemTapped, userId: '');
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
        return StudySessionPage(
          moduleId: _currentModuleId ?? '',
          onNavigate: _onItemTapped,
        );
      case 13:
        return AddProduct(onNavigate: _onItemTapped);
      case 14:
        return EditProduct(onNavigate: _onItemTapped, productId: '');
      case 15:
        return TestScreen(
          moduleId: _currentModuleId ?? '',
          onNavigate: _onItemTapped,
        );
      case 16:
        return FlashcardScreen(
          moduleId: _currentModuleId ?? '',
          onNavigate: _onItemTapped,
        );
      case 17:
        return OrderScreen(onNavigate: _onItemTapped);
      case 18:
        return UpdateProfileScreen(onNavigate: _onItemTapped);
      case 19:
        return UpdatePasswordScreen(onNavigate: _onItemTapped);
      case 22:
        return CourseEditScreen(
          moduleId: _currentModuleId ?? '',
          onNavigate: _onItemTapped,
        );
      case 23:
        return TestResultScreen(
          onNavigate: _onItemTapped,
          quizResultId: _currentQuizResultId ?? '',
          moduleId: _currentModuleId ?? '',
        );
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pagesWithHeader.contains(_selectedIndex)
          ? Header(
              onHomeTap: () => _onItemTapped(0),
              onNotificationTap: () => _onItemTapped(5),
              onAuthTap: () => _onItemTapped(6),
              onAccountTap: () => _onItemTapped(4),
              onLogoutTap: () async {
                String message = await AuthService().signOut();
                if (message == "Đăng xuất thành công!") {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('user_role');
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                  _onItemTapped(0);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                }
              },
            )
          : null,
      body: _getPage(_selectedIndex),
      bottomNavigationBar: _pagesWithBottomNavigationBar.contains(_selectedIndex)
          ? CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            )
          : null,
    );
  }
}