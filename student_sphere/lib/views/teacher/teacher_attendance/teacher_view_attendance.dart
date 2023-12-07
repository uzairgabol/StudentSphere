import 'package:student_sphere/consts/consts.dart';
import 'teacher_add_attendance.dart';
import 'teacher_edit_attendance.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/teachers/attendance/";
var link1 = link + "coursecountteacher.php";
var link2 = link + "getdates.php";

class TeacherAttendancePage extends StatefulWidget {
  final String tId;

  const TeacherAttendancePage({super.key, required this.tId});
  @override
  _TeacherAttendancePageState createState() => _TeacherAttendancePageState();
}

class _TeacherAttendancePageState extends State<TeacherAttendancePage> {

  void initState() {
    super.initState();
    // Fetch courses first
    fetchCourses().then((_) {
      // After courses are fetched, fetch attendance data
      fetchAttendanceData(widget.tId, coursesec[current].substring(0, coursesec[current].length - 3), coursesec[current].substring(coursesec[current].length - 2));
    });
  }

  int current = 0;

  // Dummy data for courses
  // List<String> courses = ["CS8890", "CS8891", "CS8892", "CS8893"];

  List<String> coursesec = [];

  // Dummy data for dates
  // List<String> dates = ["2023-04-09", "2023-04-10", "2023-04-11", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12", "2023-04-12"];

  List<Map<String, dynamic>> dates = [];

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
            coursesec = List<String>.from(jsonResponse);
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

  Future<void> fetchAttendanceData(String teacherId, String courseId, String sectionId) async {
    dates = [];
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {'teacher_id': teacherId, 'course_id': courseId, 'section': sectionId},
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            dates = List<Map<String, dynamic>>.from(jsonResponse);
          });
        } else {
          print(teacherId);
          print(courseId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Teacher Attendance Page"),
        centerTitle: true,
        automaticallyImplyLeading: false,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of Courses
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: coursesec.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                        // Fetch attendance data for the selected course
                        fetchAttendanceData(widget.tId, coursesec[current].substring(0, coursesec[current].length - 3),coursesec[current].substring(coursesec[current].length - 2));
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: current == index ? tealColor : const Color(
                            0xffB0BEC5),
                        borderRadius: BorderRadius.circular(20),
                        border: current == index
                            ? Border.all(color: Colors.deepPurpleAccent, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          coursesec[index],
                          style: TextStyle(
                            color: current == index ? Colors.white : const Color(0xff333333),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Heading for S.no and Dates
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.teal,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'S.no',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Dates',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // List of Dates
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dates.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    String courseData = coursesec[current];
                    String selectedCourse = courseData.substring(0, courseData.length - 3);
                    String selectedSection = courseData.substring(courseData.length - 2);
                    // Navigate to TeacherEditAttendance with selected date, course, and section
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                          Get.to(TeacherEditAttendance(
                            tId: widget.tId,
                          selectedDate: dates[index]['dates'],
                          selectedCourse: selectedCourse, // Pass selected course
                          selectedSection: selectedSection, // Replace with actual selected section
                        ),
                      );
                    //);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  dates[index]['dates'],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => TeacherAddAttendance()),
          // );
          Get.to(TeacherAddAttendance(tId: widget.tId));
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
