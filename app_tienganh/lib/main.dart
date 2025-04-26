// import 'package:flutter/material.dart';
// import 'routes/navigation_page.dart'; 
// // import 'package:app_tienganh/services/mongodb.dart';

// // void main() async{
// //   await MongoDatabase.connect(); // Kết nối đến MongoDB
// //   MongoDatabase.userCollection; // Lấy collection "users"
// //   debugPrint("Kết nối đến MongoDB thành công");
// //   MongoDatabase.close(); // Đóng kết nối sau khi sử dụng
// //   runApp(const MyApp());
// // }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp( 
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: const NavigationPage(),
        
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'routes/navigation_page.dart'; 

void main() {
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
