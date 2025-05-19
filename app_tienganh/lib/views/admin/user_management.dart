import 'package:flutter/material.dart';
import 'package:app_tienganh/widgets/top_app_bar.dart';
import 'package:app_tienganh/widgets/user_account_inf.dart';
import 'package:app_tienganh/core/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagement extends StatefulWidget {
  final Function(int) onNavigate;

  const UserManagement({super.key, required this.onNavigate});

  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
        title: "Trang chủ",
        onItemTapped: (int value) {
          switch (value) {
            case 1: 
              widget.onNavigate(9);
              break;
            case 2:
               widget.onNavigate(10);
              break;
            case 3:
               widget.onNavigate(11);
              break;
            case 4:
              widget.onNavigate(21);
              break;
                case 6:
              widget.onNavigate(6);
        break;
            default:
              // Xử lý khác nếu có
              break;
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: usersCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Đã xảy ra lỗi khi tải dữ liệu người dùng');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final usersData = snapshot.data!.docs;
                final userCount = usersData.length;

                return Text(
                  'Tổng số người dùng: $userCount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: AppColors.highlightDarkest,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: usersCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Đã xảy ra lỗi khi tải dữ liệu người dùng');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  final usersData = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: usersData.length,
                    itemBuilder: (context, index) {
                      final userDoc = usersData[index];
                      final userData =
                          userDoc.data() as Map<String, dynamic>?;

                      if (userData == null) {
                        return const SizedBox
                            .shrink(); 
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: UserInfoCard(
                          name: userData['username'],
                          email: userData['email'],
                          orderCount:
                              (userData['orderCount'] as num?)?.toInt() ?? 0,
                          courseCount: (userData['learningModuleCount']
                                  as num?)
                              ?.toInt() ??
                              0,
                          onDelete: () async {
                            try {
                              await usersCollection.doc(userDoc.id).delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Đã xóa người dùng thành công!'),
                                ),
                              );
                              setState(() {});
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Lỗi khi xóa người dùng: $error'),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

