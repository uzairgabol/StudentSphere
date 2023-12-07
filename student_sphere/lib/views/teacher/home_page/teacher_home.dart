// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:student_sphere/consts/colors.dart';
// import 'package:student_sphere/views/teacher/home/teacher_home.dart';
// import 'package:student_sphere/views/teacher/profile/profile.dart';
// import 'package:student_sphere/views/teacher/teacher_attendance/teacher_view_attendance.dart';
// import 'package:student_sphere/views/teacher/teacher_marks/teacher_marks_view.dart';
//
// int _pageIndex = 0;
// class TeacherHomePage extends StatefulWidget {
//   final String teacher_id;
//   const TeacherHomePage({super.key, required this.teacher_id});
//
//   @override
//   _TeacherHomePageState createState() => _TeacherHomePageState();
// }
//
// class _TeacherHomePageState extends State<TeacherHomePage> {
//
//   //late String stuId = widget.student_id;
//
//   @override
//   void initState() {
//     super.initState();
//     late String tId = widget.teacher_id;
//     _pages = [
//       TeacherHome(tId: tId),
//       TeacherMarksView(tId: tId),
//       TeacherAttendancePage(tId: tId),
//       TeacherProfileScreen(tId: tId),
//       // HomeScreen(idStudent: stuId),
//       // StudentMarks(stuId: stuId),
//       // StudentAttendance(stuId: stuId),
//       // Alumni(stuId: stuId),
//       // ProfileScreen(stuId: stuId),
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
//         color: primaryColor,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
//           child: GNav(
//             backgroundColor: primaryColor,
//             color: Colors.white,
//             activeColor: Colors.white,
//             tabBackgroundColor: secondaryColor,//Colors.grey.shade800,
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
//               // GButton(
//               //   icon: Icons.network_cell_rounded,
//               //   text: 'Alumini',
//               // ),
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
import 'package:student_sphere/consts/colors.dart';
import 'package:student_sphere/views/teacher/home/teacher_home.dart';
import 'package:student_sphere/views/teacher/profile/profile.dart';
import 'package:student_sphere/views/teacher/teacher_attendance/teacher_view_attendance.dart';
import 'package:student_sphere/views/teacher/teacher_marks/teacher_marks_view.dart';

class TeacherHomePage extends StatefulWidget {
  final String teacher_id;

  const TeacherHomePage({Key? key, required this.teacher_id}) : super(key: key);

  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  int _pageIndex = 0;

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
              //s_buildNavItem(Icons.person, 'Profile'),
              _buildNavItem(Icons.home, 'Home'),
              _buildNavItem(Icons.school, 'Marks'),
              _buildNavItem(Icons.event, 'Attendance'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return TeacherHome(tId: widget.teacher_id);
      case 1:
        return TeacherMarksView(tId: widget.teacher_id);
      case 2:
        return TeacherAttendancePage(tId: widget.teacher_id);
      case 3:
        return TeacherProfileScreen(tId: widget.teacher_id);
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
