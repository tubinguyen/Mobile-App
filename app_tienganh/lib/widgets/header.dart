import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onAuthTap;
  final VoidCallback onLogoutTap;
  final VoidCallback onAccountTap;

  const Header({
    super.key,
    required this.onHomeTap,
    required this.onNotificationTap,
    required this.onAuthTap,
    required this.onLogoutTap,
    required this.onAccountTap
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      title: GestureDetector(
        onTap: onHomeTap,
        child: Row(
          children: [
            Image.asset(
              'assets/img/logoEddy.png',
              height: 40,
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/img/noti.svg',
                  width: 20,
                  height: 23,
                ),
                onPressed: onNotificationTap,
              ),
              StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    return PopupMenuButton<String>(
                      icon: Row(
                        children: [
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .snapshots(),
                            builder: (context, firestoreSnapshot) {
                              if (firestoreSnapshot.hasData && firestoreSnapshot.data!.exists) {
                                final userData =
                                    firestoreSnapshot.data!.data() as Map<String, dynamic>?;
                                final username = userData?['username'] as String? ?? 'Người dùng';
                                return Text(
                                  'Hi, $username',
                                  style: const TextStyle(
                                    color: AppColors.highlightDarkest,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                );
                              } else if (firestoreSnapshot.hasError) {
                                return const Text('Lỗi tải tên',
                                    style: TextStyle(color: AppColors.highlightDarkest));
                              } else if (firestoreSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.highlightDarkest),
                                  strokeWidth: 2,
                                );
                              } else {
                                return const Text('Hi, Người dùng', 
                                    style: TextStyle(color: AppColors.highlightDarkest));
                              }
                            },
                          ),
                        ],
                      ),
                      color: AppColors.highlightDarkest,
                      elevation: 2,
                      position: PopupMenuPosition.under,
                      onSelected: (value) {
                        if (value == 'logout') {
                          onLogoutTap();
                        }
                        if (value == 'account') {
                          onAccountTap();
                        }
                      },
                      itemBuilder: (context) => [
                         PopupMenuItem(
                          value: 'account',
                          child: Text(
                            'Tài khoản',
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'logout',
                          child: Text(
                            'Đăng xuất',
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return PopupMenuButton<String>(
                      icon: SvgPicture.asset(
                        'assets/img/account.svg',
                        height: 20,
                      ),
                      color: AppColors.highlightDarkest,
                      elevation: 2,
                      position: PopupMenuPosition.under,
                      onSelected: (value) {
                        if (value == 'login') {
                          onAuthTap();
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'login',
                          child: Text(
                            'Đăng nhập',
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}