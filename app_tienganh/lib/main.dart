import 'package:flutter/material.dart';
import 'routes/navigation_page.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// void main() async{
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await [
//   //   Permission.photos,
//   //   Permission.videos,
//   //   Permission.audio,
//   //   Permission.storage,
//   // ].request();
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Thêm dữ liệu vào Firestore
  try {
    await FirebaseFirestore.instance.collection('messages').add({
      'text': 'Hello, world!',
      'timestamp': FieldValue.serverTimestamp(),
    });
    debugPrint('Dữ liệu đã được thêm thành công!');
  } catch (e) {
    debugPrint('Lỗi khi thêm dữ liệu vào Firestore: $e');
    // In thêm chi tiết lỗi
    debugPrint('Chi tiết lỗi: ${e.toString()}');
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const NavigationPage(),
    );
  }
}
