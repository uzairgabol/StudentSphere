import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/admin/";
var link1 = link + "remove_enrollment.php";

class UnenrollStudentPage extends StatefulWidget {
  @override
  _UnenrollStudentPageState createState() => _UnenrollStudentPageState();
}

class _UnenrollStudentPageState extends State<UnenrollStudentPage> {
  TextEditingController studentIdController = TextEditingController();
  TextEditingController courseIdController = TextEditingController();

  Future<void> unenrollStudentFromCourse() async {
    String studentId = studentIdController.text;
    String courseId = courseIdController.text;

    if (studentId.isEmpty || courseId.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in both Student ID and Course ID."),
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

    try {
      final response = await http.post(
        Uri.parse(link1),
        body: {
          'student_id': studentId,
          'course_id': courseId,
        },
      );

      if (response.statusCode == 200) {

        if (response.body.toLowerCase().contains('success')) {
          // If the server returns a success message, show success dialog
          _showSuccessDialog();
        } else {
          // If the server returns an error message, show error dialog
          _showErrorDialog(response.body);
        }
      } else {
        // Unsuccessful unenrollment
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Failed to unenroll student. Please try again."),
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
    } catch (e) {
      // Exception occurred (e.g., network error)
      print("Error: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("An error occurred. Please try again."),
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

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Student unenrolled from the course successfully!"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unenroll Student from Course"),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField("Student ID", studentIdController),
            SizedBox(height: 20),
            _buildTextField("Course ID", courseIdController),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: unenrollStudentFromCourse,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.teal,
              ),
              child: Text(
                "Unenroll Student",
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
