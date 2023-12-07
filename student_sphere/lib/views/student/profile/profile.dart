// // import 'package:student_sphere/consts/consts.dart';
// // import 'package:student_sphere/views/authentication_screen/login_screen/login.dart';
// //
// // class ProfileScreen extends StatefulWidget {
// //   final String stuId;
// //
// //   const ProfileScreen({Key? key, required this.stuId}) : super(key: key);
// //
// //   @override
// //   State<ProfileScreen> createState() => _ProfileScreenState();
// // }
// //
// // class _ProfileScreenState extends State<ProfileScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Profile'),
// //         automaticallyImplyLeading: false,
// //         centerTitle: true,
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               'User ID: ${widget.stuId}',
// //               style: TextStyle(fontSize: 18),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Show the sign-out confirmation dialog
// //                 _showSignOutConfirmationDialog();
// //               },
// //               child: Text('Sign Out'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Function to show the sign-out confirmation dialog
// //   Future<void> _showSignOutConfirmationDialog() async {
// //     return showDialog<void>(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('Sign Out'),
// //           content: Text('Are you sure you want to sign out?'),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop(); // Close the dialog
// //               },
// //               child: Text('No'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 // Perform sign-out logic here
// //                 _signOut();
// //                 Navigator.of(context).pop(); // Close the dialog
// //               },
// //               child: Text('Yes'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   // Function to handle sign-out
//   void _signOut() {
//     // Add your sign-out logic here
//     // For example, clear user credentials, reset authentication state, etc.
//
//     // Simulate a delay (replace this with your actual sign-out logic)
//     Future.delayed(Duration(seconds: 2), () {
//       // Navigate to the login screen using GetX
//       Get.off(() => LoginPage());
//     });
//   }
// //
// //
// // }
//
// import 'package:student_sphere/consts/consts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:http/http.dart' as http;
// import 'package:student_sphere/views/authentication_screen/login_screen/login.dart';
//
//
// var link = localhostip + "/api/students/";
// var link1 = link + "courses.php";
// var link2 = link + "attendance.php";
// var link3= link+"graphdatamarks.php";
//
//
//
//
// class ChartPage extends StatefulWidget {
//   final String stuId;
//
//   const ChartPage({super.key, required this.stuId});
//
//   @override
//   _ChartPageState createState() => _ChartPageState();
// }
//
//
// class _ChartPageState extends State<ChartPage> {
//   final List<ChartData> marksData = [];
//   double totalTotalMarks1=0;
//   double totalObtainedMarks1=0;
//
//   Future<void> fetchData(String studentId,String courseId,int index ) async {
//
//     try {
//       // Make a POST request to the API
//       var response = await http.post(Uri.parse(link3), body: {
//         'student_id': studentId,
//         'course_id': courseId,
//       });
//
//       // Check if the request was successful
//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         Map<String, dynamic> responseData = json.decode(response.body);
//
//         // Check if the response has the expected keys
//         if (responseData.containsKey('totalTotalMarks') && responseData.containsKey('totalObtainedMarks')) {
//           // Extract values from the response
//           String totalTotalMarks = responseData['totalTotalMarks'];
//           String totalObtainedMarks = responseData['totalObtainedMarks'];
//           totalTotalMarks1 = double.parse(totalTotalMarks);
//           totalObtainedMarks1 = double.parse(totalObtainedMarks);
//
//           // Use the values as needed
//           double percentage=totalObtainedMarks1*100/totalTotalMarks1;
//           double roundedPercentage = percentage.roundToDouble();
//           ChartData data =ChartData(courses[index], roundedPercentage);
//           marksData.add(data);
//           print('Total Total Marks: $totalTotalMarks1');
//           print('Total Obtained Marks: $totalObtainedMarks1');
//         } else {
//           // If the response does not have the expected keys, print an error
//           print('Invalid response format');
//         }
//       } else {
//         // If the request was not successful, throw an exception with the error code
//         throw Exception('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle any exceptions that occurred during the API request
//       print('Error: $e');
//     }
//   }
//
//   double CalculatePercentage(List<Map<String, dynamic>> attendanceData, String status) {
//     int totalDays = attendanceData.length;
//     int presentDays = attendanceData
//         .where((attendance) => attendance['status'] == status)
//         .length;
//
//     return (presentDays / totalDays) * 100;
//   }
//
//
//   // Dummy data for student marks
//
//
//
//   final List<ChartData> attendanceData1 = [];
//   List<String> courses = [];
//   int current = 0;
//   List<Map<String, dynamic>> AttendanceData = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch courses first
//     fetchCourses().then((_) {
//       for (int index = 0; index < courses.length; index++) {
//         String course = courses[index];
//         fetchAttendanceData(widget.stuId, course, index);
//         fetchData(widget.stuId, course,index);
//       }
//
//       //  print(AttendanceData);
//     });
//   }
//
//   Future<void> fetchCourses() async {
//     try {
//       final response = await http.post(
//         Uri.parse(link1),
//         body: {'student_id': widget.stuId}, // Replace with the actual student ID
//       );
//
//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         dynamic jsonResponse = json.decode(response.body);
//
//         if (jsonResponse is List<dynamic>) {
//           setState(() {
//             courses = List<String>.from(jsonResponse);
//             print(AttendanceData);
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
//   Future<void> fetchAttendanceData(String studentId, String courseId,int index) async {
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
//             AttendanceData = List<Map<String, dynamic>>.from(jsonResponse);
//           });
//           double attendence_percentage=CalculatePercentage(AttendanceData, 'Present');
//           double roundedPercentage = attendence_percentage.roundToDouble();
//           ChartData data =ChartData(courses[index], roundedPercentage);
//           attendanceData1.add(data);
//         } else {
//           print(studentId);
//           print(courseId);
//           print('Unexpected response format: $jsonResponse');
//         }
//       } else {
//         // If the server did not return a 200 OK response,
//         // throw an exception.
//         print('Failed to load attendance data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // String course1 = 'Course1';
//     // String course2 = 'Course2';
//     // String course3 = 'Course3';
//     //
//     // double percentageCourse1 = calculatePercentage(course1);
//     // double percentageCourse2 = calculatePercentage(course2);
//     // double percentageCourse3 = calculatePercentage(course3);
//     // print(percentageCourse1);
//     // print(percentageCourse2);
//     // print(percentageCourse3);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xff1976D2),
//         title: Text('Performance Graph'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 color: Colors.lightBlue[50],
//                 height: 350, // Set the height of the chart container
//                 child:  SfCartesianChart(
//                   title: ChartTitle(
//                     text: 'Student Marks',
//                     textStyle: TextStyle(fontSize: 20, color: Colors.black),
//                   ),
//                   plotAreaBackgroundColor: Colors.lightBlue[50],
//                   primaryXAxis: CategoryAxis(),
//                   primaryYAxis: NumericAxis(
//                     // Customize the major tick lines
//                     majorTickLines: MajorTickLines(size: 20),
//                     // Specify the axis range
//                     minimum: 0,
//                     maximum: 100,
//                     // Customize the axis labels
//                     interval: 20,
//                     numberFormat: NumberFormat.decimalPattern(),
//                   ),
//                   series: <ChartSeries>[
//                     BarSeries<ChartData, String>(
//                       dataSource: marksData,
//                       xValueMapper: (ChartData data, _) => data.category,
//                       yValueMapper: (ChartData data, _) => data.value,
//                       color: Colors.blue,
//                       width: 0.7,
//                       dataLabelSettings: DataLabelSettings(
//                         isVisible: true,
//                         textStyle: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 32),
//               Container(
//                 color: Colors.lightGreen[50],
//                 height: 350, // Set the height of the chart container
//                 child: SfCartesianChart(
//                   title: ChartTitle(
//                     text: 'Student Attendance',
//                     textStyle: TextStyle(fontSize: 20, color: Colors.black),
//                   ),
//                   plotAreaBackgroundColor: Colors.lightGreen[50],
//                   primaryXAxis: CategoryAxis(),
//                   primaryYAxis: NumericAxis(
//                     // Customize the major tick lines
//                     majorTickLines: MajorTickLines(size: 20),
//                     // Specify the axis range
//                     minimum: 0,
//                     maximum: 100,
//                     // Customize the axis labels
//                     interval: 20,
//                     numberFormat: NumberFormat.decimalPattern(),
//                   ),
//                   series: <ChartSeries>[
//                     BarSeries<ChartData, String>(
//                       dataSource: attendanceData1,
//                       xValueMapper: (ChartData data, _) => data.category,
//                       yValueMapper: (ChartData data, _) => data.value,
//                       color: Colors.green,
//                       width: 0.7,
//                       dataLabelSettings: DataLabelSettings(
//                         isVisible: true,
//                         textStyle: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 ),
//
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChartData {
//   final String category;
//   final double value;
//
//   ChartData(this.category, this.value);
// }
import 'package:student_sphere/consts/consts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:student_sphere/views/authentication_screen/login_screen/login.dart';

var link = localhostip + "/api/students/";
var link1 = link + "courses.php";
var link2 = link + "attendance.php";
var link3 = link + "graphdatamarks.php";

class ProfileScreen extends StatefulWidget {
  final String stuId;

  const ProfileScreen({Key? key, required this.stuId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<ChartData> marksData = [];
  final List<ChartData> attendanceData1 = [];
  double totalTotalMarks1 = 0;
  double totalObtainedMarks1 = 0;
  List<String> courses = [];
  int current = 0;
  List<Map<String, dynamic>> AttendanceData = [];

  Future<void> fetchData(String studentId, String courseId, int index) async {
    try {
      var response = await http.post(Uri.parse(link3), body: {
        'student_id': studentId,
        'course_id': courseId,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('totalTotalMarks') &&
            responseData.containsKey('totalObtainedMarks')) {
          String totalTotalMarks = responseData['totalTotalMarks'];
          String totalObtainedMarks = responseData['totalObtainedMarks'];
          totalTotalMarks1 = double.parse(totalTotalMarks);
          totalObtainedMarks1 = double.parse(totalObtainedMarks);

          double percentage = totalObtainedMarks1 * 100 / totalTotalMarks1;
          double roundedPercentage = percentage.roundToDouble();
          ChartData data = ChartData(courses[index], roundedPercentage);
          marksData.add(data);
        } else {
          print('Invalid response format');
        }
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  double calculatePercentage(List<Map<String, dynamic>> attendanceData, String status) {
    int totalDays = attendanceData.length;
    int presentDays = attendanceData.where((attendance) => attendance['status'] == status).length;

    return (presentDays / totalDays) * 100;
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

  Future<void> fetchAttendanceData(String studentId, String courseId, int index) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {'student_id': studentId, 'course_id': courseId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            AttendanceData = List<Map<String, dynamic>>.from(jsonResponse);
          });
          double attendence_percentage = calculatePercentage(AttendanceData, 'Present');
          double roundedPercentage = attendence_percentage.roundToDouble();
          ChartData data = ChartData(courses[index], roundedPercentage);
          attendanceData1.add(data);
        } else {
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
  void initState() {
    super.initState();
    fetchCourses().then((_) {
      for (int index = 0; index < courses.length; index++) {
        String course = courses[index];
        fetchAttendanceData(widget.stuId, course, index);
        fetchData(widget.stuId, course, index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _showSignOutConfirmationDialog();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.lightBlue[50],
                height: 350,
                child: SfCartesianChart(
                  title: ChartTitle(
                    text: 'Student Marks',
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  plotAreaBackgroundColor: Colors.lightBlue[50],
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    majorTickLines: MajorTickLines(size: 20),
                    minimum: 0,
                    maximum: 100,
                    interval: 20,
                    numberFormat: NumberFormat.decimalPattern(),
                  ),
                  series: <ChartSeries>[
                    BarSeries<ChartData, String>(
                      dataSource: marksData,
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.value,
                      color: Colors.blue,
                      width: 0.7,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Container(
                color: Colors.lightGreen[50],
                height: 350,
                child: SfCartesianChart(
                  title: ChartTitle(
                    text: 'Student Attendance',
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  plotAreaBackgroundColor: Colors.lightGreen[50],
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    majorTickLines: MajorTickLines(size: 20),
                    minimum: 0,
                    maximum: 100,
                    interval: 20,
                    numberFormat: NumberFormat.decimalPattern(),
                  ),
                  series: <ChartSeries>[
                    BarSeries<ChartData, String>(
                      dataSource: attendanceData1,
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.value,
                      color: Colors.green,
                      width: 0.7,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showSignOutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Sign Out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to sign out?',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'No',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform sign-out logic here
                _signOut();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Yes',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }


  void _signOut() {
    // Add your sign-out logic here
    // For example, clear user credentials, reset authentication state, etc.

    // Simulate a delay (replace this with your actual sign-out logic)
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the login screen using GetX
      Get.off(() => LoginPage());
    });
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
