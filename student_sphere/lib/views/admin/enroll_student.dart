// import 'dart:html';
//
// import 'package:proto/consts/consts.dart';
//
// class EnrollStudentPage extends StatefulWidget {
//   @override
//   _EnrollStudentPageState createState() => _EnrollStudentPageState();
// }
//
// class _EnrollStudentPageState extends State<EnrollStudentPage> {
//   TextEditingController studentIdController = TextEditingController();
//   TextEditingController courseIdController = TextEditingController();
//   TextEditingController teacherIdController = TextEditingController();
//   TextEditingController sectionIdController = TextEditingController();
//
//   void enrollStudentInCourse() {
//     String studentId = studentIdController.text;
//     String courseId = courseIdController.text;
//     String teacherId = teacherIdController.text;
//     String sectionId = sectionIdController.text;
//
//     if (studentId.isEmpty || courseId.isEmpty || teacherId.isEmpty || sectionId.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text("Please fill in all fields."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//       return; // Stop execution if there are empty fields
//     }
//
//     // Display confirmation
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirmation"),
//           content: Text("Enroll Student ID: $studentId in Course ID: $courseId?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Here you can add logic to enroll the student in the course
//                 Navigator.of(context).pop();
//                 _showSuccessDialog();
//               },
//               child: Text("Enroll"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Cancel"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Success"),
//           content: Text("Student enrolled in the course successfully!"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Get.back();
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Enroll Student in Course"),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildTextField("Student ID", studentIdController),
//             SizedBox(height: 20),
//             _buildTextField("Course ID", courseIdController),
//             SizedBox(height: 20),
//             _buildTextField("Teacher ID", teacherIdController),
//             SizedBox(height: 20),
//             _buildTextField("Section", sectionIdController),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: enrollStudentInCourse,
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 backgroundColor: Colors.teal
//               ),
//               child: const Text(
//                 "Enroll Student",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, TextEditingController controller,
//       {TextInputType? keyboardType, bool obscureText = false}) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         labelText: label,
//       ),
//     );
//   }
// }
import 'package:student_sphere/consts/consts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/admin/";
var link1 = link + "insert_enrollment.php";

class EnrollStudentPage extends StatefulWidget {
  @override
  _EnrollStudentPageState createState() => _EnrollStudentPageState();
}

class _EnrollStudentPageState extends State<EnrollStudentPage> {
  TextEditingController studentIdController = TextEditingController();
  TextEditingController courseIdController = TextEditingController();
  TextEditingController teacherIdController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();

  void enrollStudentInCourse() async {
    String studentId = studentIdController.text;
    String courseId = courseIdController.text;
    String teacherId = teacherIdController.text;
    String sectionId = sectionIdController.text;

    if (studentId.isEmpty || courseId.isEmpty || teacherId.isEmpty || sectionId.isEmpty) {
      _showErrorDialog("Please fill in all fields.");
      return;
    }

    try {
      var response = await http.post(
        Uri.parse(link1), // Replace with your API URL
        body: {
          'student_id': studentId,
          'course_id': courseId,
          'teacher_id': teacherId,
          'section': sectionId,
          'admin_id': "01"
        },
      );

      if (response.statusCode == 200) {
        // Parse the response to check if enrollment was successful
        if (response.body.toLowerCase().contains('success')) {
          // If the server returns a success message, show success dialog
          _showSuccessDialog();
        } else {
          // If the server returns an error message, show error dialog
          _showErrorDialog(response.body);
        }
      } else {
        // If the server returns an error response, show error dialog with the message
        _showErrorDialog("Error: ${response.body}");
      }
    } catch (e) {
      // Handle exceptions (e.g., network error) and show error dialog
      print("Error: $e");
      _showErrorDialog("An error occurred. Please try again.");
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Student enrolled in the course successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.back();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close error dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enroll Student in Course"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField("Student ID", studentIdController),
            SizedBox(height: 20),
            _buildTextField("Course ID", courseIdController),
            SizedBox(height: 20),
            _buildTextField("Teacher ID", teacherIdController),
            SizedBox(height: 20),
            _buildTextField("Section", sectionIdController),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: enrollStudentInCourse,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.teal,
              ),
              child: const Text(
                "Enroll Student",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType, bool obscureText = false}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
