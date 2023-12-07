// import 'package:student_sphere/consts/consts.dart';
// import 'package:student_sphere/widgets_common/container_heading.dart';
// import 'package:student_sphere/widgets_common/container_text.dart';
// import 'package:http/http.dart' as http;
//
// var link = localhostip + "/api/students/read2.php";
//
// Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
//   final response = await http.post(Uri.parse(link));
//
//   if (response.statusCode == 200) {
//     final List<dynamic> data = json.decode(response.body);
//     return List<Map<String, dynamic>>.from(data);
//   } else {
//     throw Exception('Failed to load data from the API');
//   }
// }
//
// Future<Map<String, dynamic>> fetchDataFromApis(String id) async {
//
//   try {
//     final response = await http.post(
//       Uri.parse(link),
//       body: {'id': id},
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
// class HomeScreen extends StatelessWidget {
//   String idStudent;
//   HomeScreen({super.key, required this.idStudent});
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: backColor,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: "Student Profile".text.fontFamily(bold).size(22).make(),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(future: fetchDataFromApis(idStudent),
//           builder: (context,snapshot){
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               // While data is still loading, show a loading indicator
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               // If there's an error, display an error message
//               return Text('Error: ${snapshot.error}');
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               // If no data is available, display a message indicating that
//               return Text('No data available');
//             }
//             else{
//               Map<String, dynamic> data = snapshot.data!;
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // Align(
//                     //     alignment: Alignment.centerLeft,
//                     //     child: ("Student Profile").text.size(22).color(Colors.black).fontFamily(bold).make()),
//                     20.heightBox,
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         containerHeading(width: context.screenWidth, title: "University Information"),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8,bottom: 8),
//                           child: Container(
//                             color: lightGrey,
//                             width: context.screenWidth,
//                             height: context.screenHeight * 0.20, //context.screenHeight * 0.20
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
//                               child: Column(
//                                 children: [
//                                   containerText(title1: "Roll No:",title2: data?['id'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "Section:",title2: data?['section'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "Degree:",title2: data?['degree'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "Campus:",title2: data?['campus'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "Status:",title2: data?['status'] ?? 'N/A'),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         20.heightBox,
//                         containerHeading(width: context.screenWidth, title: "Personal Information"),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8,bottom: 8),
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               //borderRadius: BorderRadius.circular(10),
//                               color: lightGrey,
//                             ),
//
//                             width: context.screenWidth,
//                             height: context.screenHeight * 0.25, //context.screenHeight * 0.20
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
//                               child: Column(
//                                 children: [
//                                   containerText(title1: "Name:",title2: (data?['first_name'] ?? 'N/A') + " " + (data?['last_name'] ?? 'N/A')),
//                                   8.heightBox,
//                                   containerText(title1: "Gender:",title2: data?['gender'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "DOB:",title2: data?['dob'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "Email:",title2: data?['email'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "Nationality:",title2: data?['nationality'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "Phone Number:",title2: data?['phone'] ?? 'N/A'),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         20.heightBox,
//                         containerHeading(width: context.screenWidth, title: "Family Information"),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8,bottom: 8),
//                           child: Container(
//                             color: lightGrey,
//                             width: context.screenWidth,
//                             //height: context.screenHeight * 0.12, //context.screenHeight * 0.20
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
//                               child: Column(
//                                 children: [
//                                   containerText(title1: "Relation:",title2: data?['relation'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "Name:",title2: data?['parent_name'] ?? 'N/A'),
//                                   8.heightBox,
//                                   containerText(title1: "Phone Number:",title2: data?['parent_phone'] ?? 'N/A'),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//
//                       ],
//                     ),
//
//                   ],
//                 ),
//               );
//             }
//           }),
//     );
//   }
// }
import 'package:student_sphere/consts/consts.dart';
import 'package:student_sphere/widgets_common/container_heading.dart';
import 'package:student_sphere/widgets_common/container_text.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/students/read2.php";

Future<Map<String, dynamic>> fetchDataFromApis(String id) async {
  try {
    final response = await http.post(
      Uri.parse(link),
      body: {'id': id},
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON response
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // If the request was not successful, throw an exception
      throw Exception('Failed to fetch data from the API');
    }
  } catch (e) {
    // Handle any errors that occurred during the fetch
    print('Error: $e');
    return {};
  }
}

class HomeScreen extends StatelessWidget {
  final String idStudent;
  HomeScreen({Key? key, required this.idStudent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Student Profile".text.fontFamily(bold).size(22).color(Colors.teal).make(),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDataFromApis(idStudent),
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
                    _buildCategory(context, "University Information", [
                      containerText(title1: "Roll No:", title2: data['id'] ?? 'N/A'),
                      containerText(title1: "Section:", title2: data['section'] ?? 'N/A'),
                      containerText(title1: "Degree:", title2: data['degree'] ?? 'N/A'),
                      containerText(title1: "Campus:", title2: data['campus'] ?? 'N/A'),
                      containerText(title1: "Status:", title2: data['status'] ?? 'N/A'),
                    ]),
                    _buildCategory(context, "Personal Information", [
                      containerText(
                          title1: "Name:",
                          title2: (data['first_name'] ?? 'N/A') + " " + (data['last_name'] ?? 'N/A')),
                      containerText(title1: "Gender:", title2: data['gender'] ?? 'N/A'),
                      containerText(title1: "DOB:", title2: data['dob'] ?? 'N/A'),
                      containerText(title1: "Email:", title2: data['email'] ?? 'N/A'),
                      containerText(title1: "Nationality:", title2: data['nationality'] ?? 'N/A'),
                      containerText(title1: "Phone Number:", title2: data['phone'] ?? 'N/A'),
                    ]),
                    _buildCategory(context, "Family Information", [
                      containerText(title1: "Relation:", title2: data['relation'] ?? 'N/A'),
                      containerText(title1: "Name:", title2: data['parent_name'] ?? 'N/A'),
                      containerText(title1: "Phone Number:", title2: data['parent_phone'] ?? 'N/A'),
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
}
