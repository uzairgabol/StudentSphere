import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'teacher_add_attendance_student.dart';

var link = localhostip + "/api/teachers/attendance/";
var link1 = link + "teachergetcourse.php";
var link2 = link + "teachergetsection.php";
var link3 = link + "teachercheckdate.php";

class TeacherAddAttendance extends StatefulWidget {
  final String tId;
  const TeacherAddAttendance({super.key, required this.tId});
  @override
  _TeacherAddAttendanceState createState() => _TeacherAddAttendanceState();
}

class _TeacherAddAttendanceState extends State<TeacherAddAttendance> {
  String? selectedCourse;
  String? selectedSection;
  DateTime? selectedDate;

  List<String> courses = [];
  List<String> sections = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      final response = await http.post(
        Uri.parse(link1),
        body: {'teacher_id': widget.tId},
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            courses = List<String>.from(jsonResponse);
          });
        } else {
          print('Unexpected response format: $jsonResponse');
        }
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        print('Failed to load courses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchSection(String courseID) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {'teacher_id': widget.tId, 'course_id': courseID},
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            sections = List<String>.from(jsonResponse);
          });
        } else {
          print('Unexpected response format: $jsonResponse');
        }
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        print('Failed to load sections. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)), // One year ago
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _onNextClicked(BuildContext context) async {
    if (selectedCourse == null || selectedSection == null || selectedDate == null) {
      // Show error if any field is missing
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    } else {
      // Check if attendance for the selected date already exists
      bool attendanceExists = await checkAttendance(
        selectedDate!,
        selectedCourse!,
        widget.tId,
        selectedSection!,
      );
      print(attendanceExists);
      if (attendanceExists) {
        // Show error message if attendance already exists
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attendance for the selected date already exists.'),
          ),
        );
      } else {
        // Navigate to the StudentAttendanceDataPage with the selected values
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //
        //   ),
        // );
        Get.to(
          StudentAttendanceDataPage(
            course: selectedCourse!,
            section: selectedSection!,
            date: selectedDate!,
            teacherID: widget.tId,
          ),
        );
      }
    }
  }


  Future<bool> checkAttendance(DateTime date, String courseId, String teacherId, String section) async {

    try {
      final response = await http.post(Uri.parse(link3), body: {
        'date': date.toString(),
        'course_id': courseId,
        'teacher_id': teacherId,
        'section': section,
      });

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);

        // Check the 'result' field in the response
        return data['result'] == true;
      } else {
        // Handle the error
        print('Error: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      // Handle the exception
      print('Exception: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Attendance"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(
              value: selectedCourse,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCourse = newValue!;
                  fetchSection(newValue!);
                  selectedSection = null; // Reset selectedSection when a new course is selected
                });
              },
              items: courses,
              labelText: 'Select Course',
            ),

            _buildDropdown(
              value: selectedSection,
              onChanged: (String? newValue) {
                setState(() {
                  selectedSection = newValue!;
                });
              },
              items: sections,
              labelText: 'Select Section',
            ),

            SizedBox(height: 16),

            // Input field for entering date
            _buildDateTextField(context),

            SizedBox(height: 16),

            // "Next" button
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required void Function(String?) onChanged,
    required List<String> items,
    required String labelText,
  }) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text(labelText),
    );
  }

  Widget _buildDateTextField(BuildContext context) {
    return TextFormField(
      onTap: () => _selectDate(context),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Select Date',
      ),
      controller: TextEditingController(
        text: selectedDate != null
            ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
            : '',
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onNextClicked(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        "Next",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
