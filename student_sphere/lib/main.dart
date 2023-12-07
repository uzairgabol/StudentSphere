// import 'consts/consts.dart';
// import 'views/splash_screen/splash_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "StudentSphere",
//       theme: ThemeData(
//         //scaffoldBackgroundColor: Colors.transparent,
//         scaffoldBackgroundColor: backColor,
//         appBarTheme: const AppBarTheme(
//             backgroundColor: primaryColor
//         ),
//         fontFamily: regular,
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }

import 'consts/consts.dart';
import 'views/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "StudentSphere",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Light background
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal, // Teal as the primary color
        ),
        fontFamily: regular,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.teal, // Headline text color
            fontSize: 20.0, // Headline text size
            fontWeight: FontWeight.bold, // Bold style
          ),
          bodyLarge: TextStyle(
            color: Colors.black87, // Body text color
            fontSize: 16.0, // Body text size
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.orange, // Button color
          textTheme: ButtonTextTheme.primary, // Text color for elevated buttons
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)), // Button border radius
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Button padding
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

