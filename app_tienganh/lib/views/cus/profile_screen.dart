import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/account.dart';
import '../../widgets/yourorder.dart';
import '../../widgets/text_info.dart';
import '../../widgets/large_button.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const ProfileScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final controller = LoadProfileController();
    final result = await controller.getUserInfo();

    setState(() {
      user = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (user == null) {
      return const Center(child: Text("Không tìm thấy thông tin người dùng."));
    }

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(31, 10, 31, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Account(
               profileImage: user!.avatarUrl != null && user!.avatarUrl!.isNotEmpty
              ? NetworkImage(user!.avatarUrl!)
              : AssetImage("assets/img/user.jpg") as ImageProvider,
                username: user!.username,
              ),

              const SizedBox(height: 35),

              YourOrder(
                text: 'Đơn hàng của bạn',
                onTap: () {
                  widget.onNavigate(17);
                },
              ),

              const SizedBox(height: 29),

              const Text(
                'Thông tin người dùng',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              CustomTextField(label: 'Tên', content: user!.username),
              CustomTextField(label: 'Email', content: user!.email),
              

              LargeButton(
                text: 'Cập nhật thông tin',
                onTap: () {
                  widget.onNavigate(18);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
