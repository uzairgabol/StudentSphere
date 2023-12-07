// import 'package:proto/consts/consts.dart';
// import 'package:http/http.dart' as http;
//
// class RemoveStudentPage extends StatefulWidget {
//   @override
//   _RemoveStudentPageState createState() => _RemoveStudentPageState();
// }
//
// class _RemoveStudentPageState extends State<RemoveStudentPage> {
//   TextEditingController studentIdController = TextEditingController();
//
//   void removeStudent() {
//     String studentId = studentIdController.text;
//
//     // Validate if any of the fields is empty
//     if (studentId.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: const Text("Please fill in Student ID."),
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
//           title: const Text("Are you sure you want to remove, this action is Irreversible"),
//           content: Text("Remove Student ID: $studentId?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Here you can add logic to remove the teacher
//                 Navigator.of(context).pop();
//                 _showSuccessDialog();
//               },
//               child: Text("Remove"),
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
//           content: Text("Student removed successfully!"),
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
//   void _showErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Error"),
//           content: Text("Failed to remove student. Please try again."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close error dialog
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Remove Student"),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildTextField("Student ID", studentIdController),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: removeStudent,
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 backgroundColor: Colors.teal
//               ),
//               child: Text(
//                 "Remove Student",
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
import 'package:http/http.dart' as http;

var link = localhostip + "/api/admin/";
var link1 = link + "remove_student.php";

class RemoveStudentPage extends StatefulWidget {
  @override
  _RemoveStudentPageState createState() => _RemoveStudentPageState();
}

class _RemoveStudentPageState extends State<RemoveStudentPage> {
  TextEditingController studentIdController = TextEditingController();

  Future<void> removeStudent() async {
    String studentId = studentIdController.text;

    // Validate if any of the fields is empty
    if (studentId.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: const Text("Please fill in Student ID."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return; // Stop execution if there are empty fields
    }

    // Display confirmation
    bool confirmResult = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure you want to remove? This action is irreversible."),
          content: Text("Remove Student ID: $studentId?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Remove"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );

    if (confirmResult != true) {
      return; // User canceled the operation
    }
    log(confirmResult.toString());

    // Make API call to remove student
    log(link1);
    try {
      var response = await http.post(
          Uri.parse(link1), body: {'student_id': studentId});
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, show success dialog
        _showSuccessDialog();
      }
      else {
        // If the server returns an error response, show error dialog
        _showErrorDialog();
      }
    }
      catch(e) {
        // Handle exceptions (e.g., network error) and show error dialog
        print("Error: $e");
        _showErrorDialog();
      }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Student removed successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Close this page
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Failed to remove student. Please try again."),
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
        title: Text("Remove Student"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField("Student ID", studentIdController),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: removeStudent,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.teal,
              ),
              child: Text(
                "Remove Student",
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
