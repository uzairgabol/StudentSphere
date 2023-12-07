import 'package:flutter/services.dart';
import 'package:student_sphere/consts/consts.dart';
import 'package:student_sphere/views/authentication_screen/login_screen/login.dart';

class TeacherProfileScreen extends StatefulWidget {
  final String tId;

  const TeacherProfileScreen({Key? key, required this.tId}) : super(key: key);

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User ID: ${widget.tId}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show the sign-out confirmation dialog
                _showSignOutConfirmationDialog();
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the sign-out confirmation dialog
  Future<void> _showSignOutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Perform sign-out logic here
                _signOut();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle sign-out
  void _signOut() {
    // Add your sign-out logic here
    // For example, clear user credentials, reset authentication state, etc.

    // Simulate a delay (replace this with your actual sign-out logic)
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the login screen using GetX
      Get.off(() => LoginPage());
    });
  }


}
