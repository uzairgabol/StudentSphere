// import 'package:student_sphere/consts/consts.dart';
// import 'package:student_sphere/widgets_common/container_heading.dart';
// import 'package:student_sphere/widgets_common/container_text.dart';
// import 'package:http/http.dart' as http;
//
// var link = localhostip + "/api/teachers/teacher_data_read.php";
// class TeacherHome extends StatefulWidget {
//   final String tId;
//   const TeacherHome({super.key, required this.tId});
//
//   @override
//   State<TeacherHome> createState() => _TeacherHomeState();
// }
//
// Future<Map<String, dynamic>> fetchDataFromApis(String id) async {
//   try {
//     final response = await http.post(
//       Uri.parse(link),
//       body: {'teacher_id': id},
//     );
//
//     // Check if the request was successful (status code 200)
//     if (response.statusCode == 200) {
//       // Parse the JSON response
//       Map<String, dynamic> data = json.decode(response.body);
//       return data;
//     } else {
//       // If the request was not successful, throw an exception
//       throw Exception('Failed to fetch data from the API');
//     }
//   } catch (e) {
//     // Handle any errors that occurred during the fetch
//     print('Error: $e');
//     return {};
//   }
// }
//
// class _TeacherHomeState extends State<TeacherHome> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: "Student Profile".text.fontFamily(bold).size(22).color(Colors.teal).make(),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchDataFromApis(widget.tId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No data available'));
//           } else {
//             Map<String, dynamic> data = snapshot.data!;
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildCategory(context, "Teacher Information", [
//                       containerText(title1: "Teacher Id:", title2: data['teacher_id'] ?? 'N/A'),
//                       containerText(title1: "Department:", title2: data['department'] ?? 'N/A'),
//                       containerText(title1: "Degree:", title2: data['degree'] ?? 'N/A'),
//                       containerText(title1: "Specialization:", title2: data['specialization'] ?? 'N/A'),
//                       containerText(title1: "Experience:", title2: data['yearsOfExperience'].toString() ?? 'N/A'),
//                     ]),
//                     _buildCategory(context, "Personal Information", [
//                       containerText(
//                           title1: "Name:",
//                           title2: (data['first_name'] ?? 'N/A') + " " + (data['last_name'] ?? 'N/A')),
//                       //containerText(title1: "Gender:", title2: data['gender'] ?? 'N/A'),
//                       containerText(title1: "DOB:", title2: data['dateOfBirth'] ?? 'N/A'),
//                       containerText(title1: "Email:", title2: data['email'] ?? 'N/A'),
//                       //containerText(title1: "Nationality:", title2: data['nationality'] ?? 'N/A'),
//                       //containerText(title1: "Phone Number:", title2: data['phoneNumber'] ?? 'N/A'),
//                     ]),
//                     _buildCategory(context, "Contact Information", [
//                       containerText(title1: "Address:", title2: data['address'] ?? 'N/A'),
//                       //containerText(title1: "Name:", title2: data['parent_name'] ?? 'N/A'),
//                       containerText(title1: "Phone Number:", title2: data['phoneNumber'] ?? 'N/A'),
//                       containerText(title1: "Register Number:", title2: data['registerNumber'] ?? 'N/A'),
//                     ]),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildCategory(BuildContext context, String title, List<Widget> items) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         containerHeading(width: context.screenWidth, title: title),
//         const SizedBox(height: 10),
//         Container(
//           decoration: BoxDecoration(
//             color: lightGrey,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: items,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text("Teacher Home"),
//   //       centerTitle: true,
//   //       automaticallyImplyLeading: false,
//   //     ),
//   //   );
//   // }
// }
//
//
import 'package:student_sphere/consts/consts.dart';
import 'package:student_sphere/widgets_common/container_heading.dart';
import 'package:student_sphere/widgets_common/container_text.dart';
import 'package:http/http.dart' as http;
import 'package:student_sphere/views/authentication_screen/login_screen/login.dart';

var link = localhostip + "/api/teachers/teacher_data_read.php";

class TeacherHome extends StatefulWidget {
  final String tId;
  const TeacherHome({super.key, required this.tId});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

Future<Map<String, dynamic>> fetchDataFromApis(String id) async {
  try {
    final response = await http.post(
      Uri.parse(link),
      body: {'teacher_id': id},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch data from the API');
    }
  } catch (e) {
    print('Error: $e');
    return {};
  }
}

class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Student Profile".text.fontFamily(bold).size(22).color(Colors.teal).make(),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _showSignOutConfirmationDialog();
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDataFromApis(widget.tId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            Map<String, dynamic> data = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategory(context, "Teacher Information", [
                      containerText(title1: "Teacher Id:", title2: data['teacher_id'] ?? 'N/A'),
                      containerText(title1: "Department:", title2: data['Department'] ?? 'N/A'),
                      containerText(title1: "Degree:", title2: data['degree'] ?? 'N/A'),
                      containerText(title1: "Specialization:", title2: data['specialization'] ?? 'N/A'),
                      containerText(title1: "Experience:", title2: (data['yearsOfExperience'].toString() ?? 'N/A') + " Years"),
                    ]),
                    _buildCategory(context, "Personal Information", [
                      containerText(
                          title1: "Name:",
                          title2: (data['first_name'] ?? 'N/A') + " " + (data['last_name'] ?? 'N/A')),
                      containerText(title1: "DOB:", title2: data['dateOfBirth'] ?? 'N/A'),
                      containerText(title1: "Email:", title2: data['email'] ?? 'N/A'),
                    ]),
                    _buildCategory(context, "Contact Information", [
                      containerText(title1: "Address:", title2: data['address'] ?? 'N/A'),
                      containerText(title1: "Phone Number:", title2: data['phoneNumber'] ?? 'N/A'),
                      containerText(title1: "Register Number:", title2: data['registerNumber'] ?? 'N/A'),
                    ]),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        containerHeading(width: context.screenWidth, title: title),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
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
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => LoginPage());
    });
  }
}
