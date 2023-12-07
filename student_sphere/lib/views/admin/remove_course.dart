import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/admin/";
var link1 = link + "remove_course.php";

class RemoveCoursePage extends StatefulWidget {
  @override
  _RemoveCoursePageState createState() => _RemoveCoursePageState();
}

class _RemoveCoursePageState extends State<RemoveCoursePage> {
  TextEditingController courseIdController = TextEditingController();

  Future<void> removeCourse() async {
    String courseId = courseIdController.text;

    // Validate if the field is empty
    if (courseId.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in the Course ID."),
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
      return; // Stop execution if the field is empty
    }

    // Display confirmation
    bool confirmResult = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure you want to remove? This action is irreversible."),
          content: Text("Remove Course ID: $courseId?"),
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

    // Make API call to remove course
    try {
      var response = await http.post(
        Uri.parse(link1),
        body: {'course_id': courseId},
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
          content: Text("Course removed successfully!"),
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
          content: Text("Failed to remove course. Please try again."),
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
        title: Text("Remove Course"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField("Course ID", courseIdController),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: removeCourse,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.teal,
              ),
              child: Text(
                "Remove Course",
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
