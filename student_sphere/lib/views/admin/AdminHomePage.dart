// import 'package:flutter/material.dart';
// //import 'package:modernlogintute/pages/login_page.dart';
//
// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AdminHomePage(),
//     );
//   }
// }
//
// class AdminHomePage extends StatelessWidget {
//   void signOut(BuildContext context) {
//     // Navigate to the login page
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LoginPage(),
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sign Out "),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Your page content can go here
//
//             ElevatedButton(
//               onPressed: () => signOut(context),
//               child: Text("Sign Out"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
