import 'package:flutter/material.dart';

class EnrollTeacherPage extends StatefulWidget {
  @override
  _EnrollTeacherPageState createState() => _EnrollTeacherPageState();
}

class _EnrollTeacherPageState extends State<EnrollTeacherPage> {
  TextEditingController teacherIdController = TextEditingController();
  TextEditingController courseIdController = TextEditingController();

  void enrollTeacherInCourse() {
    String teacherId = teacherIdController.text;
    String courseId = courseIdController.text;

    // Validate if any of the fields is empty
    if (teacherId.isEmpty || courseId.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in both Teacher ID and Course ID."),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Enroll Teacher ID: $teacherId in Course ID: $courseId?"),
          actions: [
            TextButton(
              onPressed: () {
                // Here you can add logic to enroll the student in the course
                Navigator.of(context).pop();
                _showSuccessDialog();
              },
              child: Text("Enroll"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
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
          content: Text("teacher enrolled in the course successfully!"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enroll Teacher in Course"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField("teacher ID", teacherIdController),
            SizedBox(height: 20),
            _buildTextField("Course ID", courseIdController),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: enrollTeacherInCourse,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                "Enroll teacher",
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
