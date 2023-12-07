import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/admin/";
var link1 = link + "remove_teacher.php";

class RemoveTeacherPage extends StatefulWidget {
  @override
  _RemoveTeacherPageState createState() => _RemoveTeacherPageState();
}

class _RemoveTeacherPageState extends State<RemoveTeacherPage> {
  TextEditingController teacherIdController = TextEditingController();

  Future<void> removeTeacher() async {
    String teacherId = teacherIdController.text;

    // Validate if any of the fields is empty
    if (teacherId.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: const Text("Please fill in Teacher ID."),
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
          title: const Text("Are you sure you want to remove? This action is irreversible"),
          content: Text("Remove Teacher ID: $teacherId"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Remove"),
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

    // Make API call to remove teacher
    try {
      var response = await http.post(
        Uri.parse(link1),
        body: {'teacher_id': teacherId},
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, show success dialog
        _showSuccessDialog();
      } else {
        // If the server returns an error response, show error dialog
        _showErrorDialog();
      }
    } catch (e) {
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
          content: Text("Teacher removed successfully!"),
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
          content: Text("Failed to remove teacher. Please try again."),
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
        title: Text("Remove Teacher"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField("Teacher ID", teacherIdController),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: removeTeacher,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.teal,
              ),
              child: const Text(
                "Remove Teacher",
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
