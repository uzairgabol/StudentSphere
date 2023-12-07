import 'teacher_marks_view_student.dart';
import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'teacher_add_marks.dart';

var link = localhostip + "/api/teachers/attendance/";
var link1 = link + "coursecountteacher.php";
var link2 = link + "getstuid.php"; // Update the link to fetch student IDs

class TeacherMarksView extends StatefulWidget {
  final String tId;
  const TeacherMarksView({super.key, required this.tId});
  @override
  _TeacherMarksViewState createState() => _TeacherMarksViewState();
}

class _TeacherMarksViewState extends State<TeacherMarksView> {
  void initState() {
    super.initState();
    // Fetch courses first
    fetchCourses().then((_) {
      // After courses are fetched, fetch attendance data
      fetchStudentIDs(
        widget.tId,
        coursesec[current].substring(0, coursesec[current].length - 3),
        coursesec[current].substring(coursesec[current].length - 2),
      );
    });
  }

  int current = 0;
  List<String> coursesec = [];
  List<Map<String, dynamic>> studentIds = []; // Change the variable name

  Future<void> fetchCourses() async {
    try {
      final response = await http.post(
        Uri.parse(link1),
        body: {'teacher_id': widget.tId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            coursesec = List<String>.from(jsonResponse);
          });
        } else {
          print('Unexpected response format: $jsonResponse');
        }
      } else {
        print('Failed to load courses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchStudentIDs(
      String teacherId,
      String courseId,
      String sectionId,
      ) async {
    studentIds = [];
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {'teacher_id': teacherId, 'course_id': courseId, 'section': sectionId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            studentIds = List<Map<String, dynamic>>.from(jsonResponse);
          });
        } else {
          print(teacherId);
          print(courseId);
          print('Unexpected response format: $jsonResponse');
        }
      } else {
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
        title: const Text("Marks"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   width: double.infinity,
            //   height: 80,
            //   child: ListView.builder(
            //     physics: const BouncingScrollPhysics(),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: coursesec.length,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             current = index;
            //             fetchStudentIDs(
            //               widget.tId,
            //               coursesec[current].substring(0, coursesec[current].length - 3),
            //               coursesec[current].substring(coursesec[current].length - 2),
            //             );
            //           });
            //         },
            //         child: Container(
            //           margin: const EdgeInsets.all(8),
            //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //           decoration: BoxDecoration(
            //             color: current == index ? const Color(0xff9BA8B2) : const Color(0xffB0BEC5),
            //             borderRadius: BorderRadius.circular(20),
            //             border: current == index
            //                 ? Border.all(color: Colors.deepPurpleAccent, width: 2)
            //                 : null,
            //           ),
            //           child: Center(
            //             child: Text(
            //               coursesec[index],
            //               style: TextStyle(
            //                 color: current == index ? Colors.white : const Color(0xff333333),
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: coursesec.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        current = index;
                        fetchStudentIDs(
                          widget.tId,
                          coursesec[current].substring(0, coursesec[current].length - 3),
                          coursesec[current].substring(coursesec[current].length - 2),
                        );
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
                            color: current == index
                                ? Colors.white
                                : const Color(0xff333333),
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
                        'Student ID', // Update the label
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: studentIds.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    String courseData = coursesec[current];
                    String selectedCourse = courseData.substring(0, courseData.length - 3);
                    String selectedSection = courseData.substring(courseData.length - 2);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => TeacherStudentMarks(
                    //       tId: widget.tId,
                    //       studentId: studentIds[index]['student_id'], // Use student ID here
                    //       courseId: selectedCourse,
                    //     ),
                    //   ),
                    // );
                    Get.to(TeacherStudentMarks(
                      tId: widget.tId,
                      studentId: studentIds[index]['student_id'],
                      courseId: selectedCourse,
                    ));
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
                                  studentIds[index]['student_id'], // Use student ID here
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
          //   MaterialPageRoute(builder: (context) => TeacherAddMarksEdit()),
          // );
          Get.to(TeacherAddMarksEdit(tId: widget.tId));
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
