import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/admin/";
var link1 = link + "insert_course.php";

class add_course extends StatefulWidget {
  @override
  _add_courseState createState() => _add_courseState();
}

class _add_courseState extends State<add_course> {
  TextEditingController courseIdController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();

  // Function to save course details
  void saveCourseDetails() async {
    String courseId = courseIdController.text;
    String courseName = courseNameController.text;

    // Validation: Check if any of the fields is empty
    if (courseId.isEmpty || courseName.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in all fields."),
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

    int maxCourseIdLength = 6;
    if (courseId.length > maxCourseIdLength) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Course ID cannot exceed $maxCourseIdLength characters."),
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
      return; // Stop execution if courseId exceeds the maximum length
    }

    // Display confirmation for course details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to save these details?\n\nCourse ID: $courseId\nCourse Name: $courseName"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _saveCourseDetails(courseId, courseName);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Function to save course details via API
  Future<void> _saveCourseDetails(String courseId, String courseName) async {
    // Add the code to save course details via API
    // Example API endpoint

    // Data to be sent in the request body
    var data = {
      'course_id': courseId,
      'course_name': courseName,
    };

    try {
      var response = await http.post(Uri.parse(link1), body: data);
      log(response.body);
      if (response.statusCode == 200) {
         showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Details saved successfully!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.back(); // Navigate back after successful course insertion
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        ); // Navigate back after successful course insertion
      } else {
        // If the server returns an error response, show error snackbar
        _showSnackbar("Failed to save course details. Please try again.", Colors.red);
      }
    } catch (e) {

      print("Error: $e");
      _showSnackbar("An error occurred. Please try again.", Colors.red);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Details saved successfully!"),
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
  // Function to show snackbar
  void _showSnackbar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Details"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: courseIdController,
              decoration: InputDecoration(labelText: "Course ID"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: courseNameController,
              decoration: InputDecoration(labelText: "Course Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveCourseDetails,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: Text("Save Details"),
            ),
          ],
        ),
      ),
    );
  }
}
