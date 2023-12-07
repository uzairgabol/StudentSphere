// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:student_sphere/views/student/alumni/alumni_main.dart';
// import 'package:student_sphere/views/student/attendance/student_attendance_page.dart';
// import 'package:student_sphere/views/student/home/home.dart';
// import 'package:student_sphere/views/student/marks/student_marks.dart';
// import 'package:student_sphere/views/student/profile/profile.dart';
//
// int _pageIndex = 0;
// class HomePage extends StatefulWidget {
//   final String student_id;
//   const HomePage({super.key, required this.student_id});
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   //late String stuId = widget.student_id;
//
//   @override
//   void initState() {
//     super.initState();
//     late String stuId = widget.student_id;
//     _pages = [
//       // HomePageContent(),
//       //HomePage1(),
//       // StudentMarksPage(),
//       // AttendencePage(),
//       // MyProfileScreen(),
//       // Alumini(),
//       HomeScreen(idStudent: stuId),
//       StudentMarks(stuId: stuId),
//       StudentAttendance(stuId: stuId),
//       Alumni(stuId: stuId),
//       ProfileScreen(stuId: stuId),
//     ];
//   }
//
//   late List<Widget> _pages;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Home Page'),
//       // ),
//       body: _pages[_pageIndex],
//       bottomNavigationBar: Container(
//         color: Colors.black,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
//           child: GNav(
//             backgroundColor: Colors.black,
//             color: Colors.white,
//             activeColor: Colors.white,
//             tabBackgroundColor: Colors.grey.shade800,
//             gap: 8,
//             onTabChange: (index) {
//               setState(() {
//                 _pageIndex = index;
//               });
//             },
//             padding: EdgeInsets.all(16),
//             tabs: const [
//               GButton(
//                 icon: Icons.home,
//                 text: 'Home',
//               ),
//               GButton(
//                 icon: Icons.school,
//                 text: 'Marks',
//               ),
//               GButton(
//                 icon: Icons.event,
//                 text: 'Attendance',
//               ),
//               GButton(
//                 icon: Icons.network_cell_rounded,
//                 text: 'Alumini',
//               ),
//               GButton(
//                 icon: Icons.person,
//                 text: 'Profile',
//               )
//             ],
//
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // class HomePageContent extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     // This is the content for the "Home" tab
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: <Widget>[
// //           Text("Welcome to the Home Page"),
// //           ElevatedButton(
// //             onPressed: () {
// //               // Sign Out button action
// //               // Add your sign-out logic here
// //               // For example, you can show a dialog for confirmation and sign the user out.
// //               Navigator.of(context).push(
// //                 MaterialPageRoute(
// //                   builder: (context) => LoginPage(),
// //                 ),
// //               );
// //             },
// //             child: Text('Sign Out'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_sphere/views/student/alumni/alumni_main.dart';
import 'package:student_sphere/views/student/attendance/student_attendance_page.dart';
import 'package:student_sphere/views/student/home/home.dart';
import 'package:student_sphere/views/student/marks/student_marks.dart';
import 'package:student_sphere/views/student/profile/profile.dart';

class HomePage extends StatefulWidget {
  final String student_id;

  const HomePage({super.key, required this.student_id});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  late String stuId = "";

  @override
  void initState() {
    super.initState();
    stuId = widget.student_id;
    print(stuId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_pageIndex),
      bottomNavigationBar: Container(
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: GNav(
            backgroundColor: Colors.teal,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
            padding: EdgeInsets.all(16),
            tabs: [
              _buildNavItem(Icons.home, 'Home'),
              _buildNavItem(Icons.school, 'Mark'),
              _buildNavItem(Icons.event, 'Att'),
              _buildNavItem(Icons.network_cell_rounded, 'Alum'),
              _buildNavItem(Icons.person, 'User'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen(idStudent: stuId);
      case 1:
        return StudentMarks(stuId: stuId);
      case 2:
        return StudentAttendance(stuId: stuId);
      case 3:
        return Alumni(stuId: stuId);
      case 4:
        return ProfileScreen(stuId: stuId);
      default:
        return Container();
    }
  }

  GButton _buildNavItem(IconData icon, String label) {
    return GButton(
      icon: icon,
      text: label,
    );
  }
}
