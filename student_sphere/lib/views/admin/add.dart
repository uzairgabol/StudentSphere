// import 'package:proto/consts/consts.dart';
// import 'add_course.dart';
// import 'add_student.dart';
// import 'add_teacher.dart';
//
// class add extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(''),
//         backgroundColor: Colors.teal,
//         automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Select an option',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               //SizedBox(height: 20),
//
//               SizedBox(height: 40),
//               _buildProfessionalCard(
//                 context,
//                 Icons.person_add,
//                 'Add Student',
//                 Colors.green,
//               ),
//               SizedBox(height: 20),
//               _buildProfessionalCard(
//                 context,
//                 Icons.school,
//                 'Add Teacher',
//                 Colors.teal,
//               ),
//               SizedBox(height: 20),
//               _buildProfessionalCard(
//                 context,
//                 Icons.book,
//                 'Add Course',
//                 Colors.blue,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfessionalCard(
//       BuildContext context,
//       IconData icon,
//       String label,
//       Color color,
//       ) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: InkWell(
//         onTap: () {
//           if (label == 'Add Student') {
//             Get.to(StudentDetailsPage());
//           } else if (label == 'Add Teacher') {
//               Get.to(AddTeacherPage());
//           } else if (label == 'Add Course') {
//             Get.to(add_course());
//           }
//         },
//         child: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 icon,
//                 size: 50,
//                 color: color,
//               ),
//               SizedBox(height: 10),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:student_sphere/consts/consts.dart';
import 'package:student_sphere/views/authentication_screen/login_screen/login.dart';
import 'add_course.dart';
import 'add_student.dart';
import 'add_teacher.dart';

class add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _showSignOutConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Select an option',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              _buildProfessionalCard(
                context,
                Icons.person_add,
                'Add Student',
                Colors.green,
              ),
              SizedBox(height: 20),
              _buildProfessionalCard(
                context,
                Icons.school,
                'Add Teacher',
                Colors.teal,
              ),
              SizedBox(height: 20),
              _buildProfessionalCard(
                context,
                Icons.book,
                'Add Course',
                Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfessionalCard(BuildContext context,
      IconData icon,
      String label,
      Color color,) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          if (label == 'Add Student') {
            Get.to(StudentDetailsPage());
          } else if (label == 'Add Teacher') {
            Get.to(AddTeacherPage());
          } else if (label == 'Add Course') {
            Get.to(add_course());
          }
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 50,
                color: color,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showSignOutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Sign Out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to sign out?',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'No',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                _signOut(context);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Yes',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  void _signOut(BuildContext context) {
    // Implement your sign-out logic here
    // For example, you can clear the user session or navigate to the login screen
    Future.delayed(Duration(seconds: 2), () {
      // Replace the following line with your actual sign-out logic
      Get.offAll(() => LoginPage());
    });
  }
}