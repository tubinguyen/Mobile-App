import 'package:flutter/material.dart';
import '../../widgets/header.dart';
import '../../widgets/navbar.dart';
import '../../widgets/content_switch.dart';
import '../../widgets/notification.dart';
import '../../widgets/libraryobject.dart';

class ReviewScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const ReviewScreen({super.key, required this.onNavigate});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int selectedIndex = 0;

  Widget _buildContentForIndex(int index) {
    String subtitle = 'Học phần này được tạo bởi bạn'; // <-- giả lập DB
    String username = 'Nhi';
    switch (index) {
      case 0: // Học phần
        List<String> hocPhanList = []; // <-- giả lập lấy từ DB

        if (hocPhanList.isEmpty) {
          return Center(
            child: NotificationCard(
              mainText: 'Bạn chưa có học phần nào',
              subText: 'các học phần bạn tạo sẽ được lưu tại đây',
              timeAgo: '9m',
              svgPath: 'assets/img/book.png',
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            ),
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: hocPhanList.length,
            itemBuilder: (context, index) {
              final hocPhan = hocPhanList[index];
              return LibraryObject(
                title: hocPhan,
                subtitle: subtitle,
                username: username,
              );
            },
          );
        }

      case 1: // Kiểm tra
        return Center(
          child: NotificationCard(
            mainText: 'Bạn chưa tạo bài kiểm tra nào',
            subText: 'Tìm và làm các bài kiểm tra thử dựa trên những gì bạn đang học',
            timeAgo: 'vừa xong',
            svgPath: 'assets/img/test.png',
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          ),
        );

      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( // Nếu Header không phải AppBar gốc
        preferredSize: Size.fromHeight(60),
        child: Header(
          onHomeTap: () => widget.onNavigate(0),
          onNotificationTap: () => widget.onNavigate(1),
          onAuthTap: () => widget.onNavigate(2),
        ),
      ),
      body: Column(
        children: [
          ContentSwitcher(
            onNavigate: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          CustomNavBar(
            title: "Thư viện của bạn",
            leadingIconPath: "assets/img/back.svg",
            actionIconPath: "assets/img/store.svg",
            onLeadingPressed: () {
              Navigator.pop(context);
            },
            onActionPressed: () {
              widget.onNavigate(3);
            },
          ),
          Expanded(
            child: _buildContentForIndex(selectedIndex),
          ),
        ],
      ),
    );
  }
}
