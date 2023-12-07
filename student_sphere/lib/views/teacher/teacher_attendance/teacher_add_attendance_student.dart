import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/teachers/attendance/";
var link1 = link + "teachergetstudent.php";
var link2 = link + "teacheraddattendance.php";
var link3 = link + "teacherupdateattendance.php";

class StudentAttendanceDataPage extends StatefulWidget {
  final String course;
  final String section;
  final DateTime date;
  final String teacherID;

  StudentAttendanceDataPage({
    required this.course,
    required this.section,
    required this.date,
    required this.teacherID,
  });

  @override
  _StudentAttendanceDataPageState createState() =>
      _StudentAttendanceDataPageState();
}

class _StudentAttendanceDataPageState
    extends State<StudentAttendanceDataPage> {


  void initState() {
    super.initState();
    // Fetch courses first
    fetchAttendanceData(widget.teacherID, widget.course, widget.section).then((_) {
      // After courses are fetched, fetch attendance data
      for (int i = 0; i < studentData.length; i++) {
        studentData[i]['status'] = 'Present';
        insertAttendance(widget.date, studentData[i]['status'], widget.course, widget.teacherID, studentData[i]['student_id']);
      }
    });
  }


  List<Map<String, dynamic>> studentData = [];


  Future<void> fetchAttendanceData(String teacherID, String courseId, String section) async {
    try {
      final response = await http.post(
        Uri.parse(link1),
        body: {'teacher_id': teacherID, 'course_id': courseId, 'section': section},
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            studentData = List<Map<String, dynamic>>.from(jsonResponse);
          });
        } else {
          print(teacherID);
          print(courseId);
          print(section);
          print('Unexpected response format: $jsonResponse');
        }
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        print('Failed to load attendance data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> insertAttendance(DateTime date, String status, String courseId, String teacherId, String studentId) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {
          'date': date.toString(),
          'status': status,
          'course_id': courseId,
          'teacher_id': teacherId,
          'student_id': studentId,
        },
      );

      if (response.statusCode == 200) {
        print("Attendance data inserted successfully");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updateAttendance(DateTime date, String status, String courseId, String teacherId, String studentId) async {
    try {
      final response = await http.post(
        Uri.parse(link3),
        body: {
          'date': date.toString(),
          'status': status,
          'course_id': courseId,
          'teacher_id': teacherId,
          'student_id': studentId,
        },
      );

      if (response.statusCode == 200) {
        if (response.body.contains("Attendance data inserted successfully") ||
            response.body.contains("Attendance data updated successfully")) {
          print("Attendance updated successfully");
        } else {
          print("Error: Unexpected response - ${response.body}");
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Data"),
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings for s.no, student_id, and status
            _buildHeadingRow(),

            // List of Student Data
            _buildStudentDataList(),

            SizedBox(height: 16),

            // "Save" button
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadingRow() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.teal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildHeadingText('S.no'),
          SizedBox(width: 16),
          _buildHeadingText('Student_id'),
          SizedBox(width: 16),
          _buildHeadingText('Status'),
        ],
      ),
    );
  }

  Widget _buildHeadingText(String text) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildStudentDataList() {
    return Expanded(
      child: ListView.builder(
        itemCount: studentData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDataText("${index + 1}", flex: 2),
                SizedBox(width: 16),
                _buildDataText(studentData[index]['student_id'], flex: 4),
                SizedBox(width: 16),
                _buildStatusDropdown(index),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDataText(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown(int index) {
    return Container(
      width: 120, // Set a fixed width for the status column
      child: Center(
        child: DropdownButton<String>(
          value: studentData[index]['status'],
          onChanged: (String? newValue) {
            setState(() {
              studentData[index]['status'] = newValue!;
              updateAttendance(widget.date, studentData[index]['status'], widget.course, widget.teacherID, studentData[index]['student_id']);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Attendance Saved'),
                  duration: Duration(seconds: 2), // You can adjust the duration as needed
                ),
              );
            });
          },
          items: <String>['Present', 'Absent']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: value.toLowerCase() == 'present'
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        // Add functionality for the "Save" button
        // Leave the function empty for now
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Attendance saved successfully.'),
          ),
        );

        // Pop back 2 pages
        //Navigator.popUntil(context, ModalRoute.withName('/'));
        Get.back();
        Get.back();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set rounded edges
        ),
      ),
      child: Text(
        "Save",
        style: TextStyle(
          color: Colors.white, // Set text color to white
        ),
      ),
    );
  }
}

