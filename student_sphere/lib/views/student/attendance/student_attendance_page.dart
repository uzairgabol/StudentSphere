// import 'package:http/http.dart' as http;
// import 'package:student_sphere/consts/consts.dart';
//
// var link = localhostip + "/api/students/";
// var link1 = link + "courses.php";
// var link2 = link + "attendance.php";
//
// class StudentAttendance extends StatefulWidget {
//   final String stuId;
//   const StudentAttendance({super.key, required this.stuId});
//
//   @override
//   State<StudentAttendance> createState() => _StudentAttendanceState();
// }
//
// class _StudentAttendanceState extends State<StudentAttendance> {
//   List<String> courses = [];
//   int current = 0;
//   List<Map<String, dynamic>> attendanceData = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch courses first
//     fetchCourses().then((_) {
//       // After courses are fetched, fetch attendance data
//       fetchAttendanceData(widget.stuId, courses[current]);
//     });
//   }
//
//   Future<void> fetchCourses() async {
//     try {
//       final response = await http.post(
//         Uri.parse(link1),
//         body: {
//           'student_id': widget.stuId
//         }, // Replace with the actual student ID
//       );
//
//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         dynamic jsonResponse = json.decode(response.body);
//
//         if (jsonResponse is List<dynamic>) {
//           setState(() {
//             courses = List<String>.from(jsonResponse);
//           });
//         } else {
//           print('Unexpected response format: $jsonResponse');
//         }
//       } else {
//         // If the server did not return a 200 OK response,
//         // throw an exception.
//         print('Failed to load courses. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   Future<void> fetchAttendanceData(String studentId, String courseId) async {
//     try {
//       final response = await http.post(
//         Uri.parse(link2),
//         body: {'student_id': studentId, 'course_id': courseId},
//       );
//
//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         dynamic jsonResponse = json.decode(response.body);
//
//         if (jsonResponse is List<dynamic>) {
//           setState(() {
//             attendanceData = List<Map<String, dynamic>>.from(jsonResponse);
//           });
//         } else {
//           print(studentId);
//           print(courseId);
//           print('Unexpected response format: $jsonResponse');
//         }
//       } else {
//         // If the server did not return a 200 OK response,
//         // throw an exception.
//         print('Failed to load attendance data. Status code: ${response
//             .statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Attendance'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Your course selection bar
//             SizedBox(
//               width: double.infinity,
//               height: 80,
//               child: ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: courses.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         current = index;
//                         // Fetch attendance data for the selected course
//                         fetchAttendanceData(widget.stuId, courses[current]);
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(8),
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: current == index ? const Color(0xff9BA8B2) : const Color(0xffB0BEC5),
//                         borderRadius: BorderRadius.circular(20),
//                         border: current == index
//                             ? Border.all(color: Colors.deepPurpleAccent, width: 2)
//                             : null,
//                       ),
//                       child: Center(
//                         child: Text(
//                           courses[index],
//                           style: TextStyle(
//                             color: current == index ? Colors.white : const Color(0xff333333),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             // Heading for date, duration, and status
//             Container(
//               padding: const EdgeInsets.all(8.0),
//               color: Colors.blue.shade500,
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Center(
//                       child: Text(
//                         'Date',
//                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     flex: 2,
//                     child: Center(
//                       child: Text(
//                         'Status',
//                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Display attendance data for the selected course
//             Expanded(
//               child: ListView.builder(
//                 itemCount: attendanceData.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: Center(
//                                 child: Text(
//                                   "${attendanceData[index]['dates']}",
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               flex: 2,
//                               child: Center(
//                                 child: Text(
//                                   "${attendanceData[index]['status']}",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: attendanceData[index]['status'].toLowerCase() == 'present'
//                                         ? Colors.green
//                                         : Colors.red,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Divider(
//                         color: Colors.grey[300],
//                         thickness: 1,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:http/http.dart' as http;
import 'package:student_sphere/consts/consts.dart';

var link = localhostip + "/api/students/";
var link1 = link + "courses.php";
var link2 = link + "attendance.php";

class StudentAttendance extends StatefulWidget {
  final String stuId;
  const StudentAttendance({super.key, required this.stuId});

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  List<String> courses = [];
  int current = 0;
  List<Map<String, dynamic>> attendanceData = [];

  @override
  void initState() {
    super.initState();
    fetchCourses().then((_) {
      fetchAttendanceData(widget.stuId, courses[current]);
    });
  }

  Future<void> fetchCourses() async {
    try {
      final response = await http.post(
        Uri.parse(link1),
        body: {'student_id': widget.stuId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            courses = List<String>.from(jsonResponse);
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

  Future<void> fetchAttendanceData(String studentId, String courseId) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {'student_id': studentId, 'course_id': courseId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            attendanceData = List<Map<String, dynamic>>.from(jsonResponse);
          });
        } else {
          print(studentId);
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
      appBar: AppBar(
        title: Text('Student Attendance'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                        fetchAttendanceData(widget.stuId, courses[current]);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: current == index ? tealColor : const Color(0xffB0BEC5),
                        borderRadius: BorderRadius.circular(20),
                        border: current == index
                            ? Border.all(color: Colors.deepPurpleAccent, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          courses[index],
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
            Container(
              padding: const EdgeInsets.all(8.0),
              color: tealColor, // Updated to match your theme
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Date',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Status',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "${attendanceData[index]['dates']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "${attendanceData[index]['status']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: attendanceData[index]['status'].toLowerCase() == 'present'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
