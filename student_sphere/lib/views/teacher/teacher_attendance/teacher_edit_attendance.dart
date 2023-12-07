import 'package:student_sphere/consts/consts.dart';
import 'teacher_edit_attendance_student.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/teachers/attendance/";
var link1 = link + "teachergetstudent.php";
var link2 = link + "teacherdeleteattendance.php";

class TeacherEditAttendance extends StatefulWidget {
  final String tId;
  final String selectedDate;
  final String selectedCourse; // Add selected course
  final String selectedSection; // Add selected section

  TeacherEditAttendance({
    required this.tId,
    required this.selectedDate,
    required this.selectedCourse,
    required this.selectedSection,
  });

  @override
  _TeacherEditAttendanceState createState() => _TeacherEditAttendanceState();
}

class _TeacherEditAttendanceState extends State<TeacherEditAttendance> {


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

  Future<void> deleteAttendance(DateTime date, String courseId, String teacherId, String studentId) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {
          'date': date.toString(),
          'course_id': courseId,
          'teacher_id': teacherId,
          'student_id': studentId,
        },
      );

      if (response.statusCode == 200) {
        print("Attendance data deleted successfully");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  var selectdate;
  void convertdate(){
    DateTime inputDate = DateFormat("dd-MMM-yyyy").parse(widget.selectedDate);

    selectdate = DateFormat("yyyy-MM-dd").format(inputDate);

    print(selectdate);
    print(widget.selectedCourse);
    print(widget.selectedSection);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convertdate();
    fetchAttendanceData(widget.tId, widget.selectedCourse, widget.selectedSection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading for selected date
            _buildSelectedDateHeading(),

            SizedBox(height: 16),


            SizedBox(height: 16),



            SizedBox(height: 16),

            // "Edit" button
            _buildEditButton(context),

            SizedBox(height: 16),

            _buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedDateHeading() {
    return Center(
      child: Text(
        "Selected Date: ${widget.selectedDate}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }


  Widget _buildDeleteButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        for (int i = 0; i < studentData.length; i++) {
          await deleteAttendance(
            DateTime.parse(selectdate),
            widget.selectedCourse,
            widget.tId,
            studentData[i]['student_id'],
          );
        }

        // After deletion is performed, show a message and navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Attendance for ${widget.selectedDate} deleted successfully."),
          ),
        );

        // Navigate back
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Red color for delete button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        "Delete",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }


  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to StudentAttendanceDataPage with selected date, course, and section
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
                Get.to(TeacherEditAttendanceStudent(
                course: widget.selectedCourse,
                section: widget.selectedSection,
                date: DateTime.parse(selectdate),
                teacherID: widget.tId,
              )
            // builder: (context) => StudentAttendanceDataPage(
            //   course: widget.selectedCourse,
            //   section: widget.selectedSection,
            //   date: DateTime.parse(selectdate),
            //   teacherID: ,
            // ),
          );
        //);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        "Edit",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
