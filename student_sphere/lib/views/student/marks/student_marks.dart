import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/students/";
var link1 = link + "courses.php";
var link2 = link + "getmarksstructure.php";
var link3 = link + "getmarks.php";

class StudentMarks extends StatefulWidget {
  final String stuId;
  const StudentMarks({super.key, required this.stuId});
  @override
  _StudentMarksState createState() => _StudentMarksState();
}

class _StudentMarksState extends State<StudentMarks> {
  int currentCourse = 0;
  List<String> courses = [];
  Map<String, List<String>> sections = {};
  Map<String, List<Map<String, dynamic>>> marksData = {};
  double grandTotalWeightage = 0;
  double grandTotalObtainedMarks = 0;
  num totalWeightageInSection = 0;
  num totalObtainedMarksInSection = 0;

  @override
  void initState() {
    super.initState();
    fetchCourses();
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
          loadSections();
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

  Future<void> loadSections() async {
    try {
      final List<Future<Map<String, List<String>>>> futures = [];
      for (String courseId in courses) {
        futures.add(fetchSectionsForCourse(courseId));
      }

      final List<Map<String, List<String>>> results = await Future.wait(
          futures);

      setState(() {
        for (int i = 0; i < courses.length; i++) {
          sections[courses[i]] = results[i][courses[i]] ?? [];
        }
      });

      loadMarks();
    } catch (e) {
      print('Error loading sections: $e');
    }
  }

  Future<Map<String, List<String>>> fetchSectionsForCourse(
      String courseId) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {'student_id': widget.stuId, 'course_id': courseId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is Map<String, dynamic>) {
          Map<String, List<String>> result = {};
          jsonResponse.forEach((key, value) {
            if (value is List<dynamic>) {
              result[key] = List<String>.from(value);
            } else {
              print('Unexpected response format for sections: $jsonResponse');
            }
          });
          return result;
        } else {
          print('Unexpected response format for sections: $jsonResponse');
        }
      } else {
        print('Failed to load sections for $courseId. Status code: ${response
            .statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return {}; // Return an empty map if there's an error
  }

  Future<void> loadMarks() async {
    try {
      final List<Future<List<Map<String, dynamic>>>> futures = [];
      for (String courseId in courses) {
        futures.add(fetchMarksForCourse(courseId));
      }

      final List<List<Map<String, dynamic>>> results = await Future.wait(
          futures);

      setState(() {
        for (int i = 0; i < courses.length; i++) {
          marksData[courses[i]] = results[i].map((mark) {
            return {
              'label_index': num.tryParse(mark['label_index'] ?? '0') ?? 0,
              'weightage': num.tryParse(mark['weightage'] ?? '0') ?? 0,
              'obtained_marks': num.tryParse(mark['obtained_marks'] ?? '0') ??
                  0,
              'total_marks': num.tryParse(mark['total_marks'] ?? '0') ?? 0,
              'main_label': mark['main_label'] ?? '',
            };
          }).toList();
        }
      });
    } catch (e) {
      print('Error loading marks: $e');
    }
  }


  Future<List<Map<String, dynamic>>> fetchMarksForCourse(
      String courseId) async {
    try {
      final response = await http.post(
        Uri.parse(link3),
        body: {'student_id': widget.stuId, 'course_id': courseId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          return List<Map<String, dynamic>>.from(jsonResponse);
        } else {
          print('Unexpected response format for marks: $jsonResponse');
        }
      } else {
        print('Failed to load marks for $courseId. Status code: ${response
            .statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return []; // Return an empty list if there's an error
  }

  Future<void> calculateTotals() async {
    totalWeightageInSection = 0;
    totalObtainedMarksInSection = 0;

    // Calculate total weightage and obtained marks for the current section
    marksData[courses[currentCourse]]?.forEach((item) {
      totalWeightageInSection += item['weightage'];
      totalObtainedMarksInSection +=
          (item['obtained_marks'] / item['total_marks']) * item['weightage'];
    });
  }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppBar(
//               title: Text('Student Marks'),
//               automaticallyImplyLeading: false,
//               centerTitle: true,
//             ),
//             SizedBox(
//               width: double.infinity,
//               height: 80,
//               child: ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: courses.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () async {
//                       setState(() {
//                         currentCourse = index;
//
//                       });
//                       await calculateTotals();
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(8),
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: currentCourse == index ? const Color(0xff9BA8B2) : const Color(0xffB0BEC5),
//                         borderRadius: BorderRadius.circular(20),
//                         border: currentCourse == index
//                             ? Border.all(color: Colors.deepPurpleAccent, width: 2)
//                             : null,
//                       ),
//                       child: Center(
//                         child: Text(
//                           courses[index],
//                           style: TextStyle(
//                             color: currentCourse == index ? Colors.white : const Color(0xff333333),
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
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: courses.isNotEmpty ? sections[courses[currentCourse]]?.length ?? 0 : 0,
//                 itemBuilder: (context, sectionIndex) {
//                   String section = sections[courses[currentCourse]]?[sectionIndex] ?? '';
//                   int rowNumber = 0;
//
//                   List<Map<String, dynamic>> sectionData = (marksData[courses[currentCourse]] ?? [])
//                       .where((data) => data['main_label'] == section)
//                       .toList();
//
//                   return ExpansionTile(
//                     title: Text(section),
//                     children: [
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: DataTable(
//                           columns: [
//                             DataColumn(label: Text('$section-#')),
//                             DataColumn(label: Text('Weightage')),
//                             DataColumn(label: Text('Obtained Marks')),
//                             DataColumn(label: Text('Total Marks')),
//                           ],
//                           rows: sectionData.map<DataRow>((mark) {
//                             rowNumber++;
//                             return DataRow(
//                               cells: [
//                                 DataCell(Text('${mark['label_index']}')),
//                                 DataCell(Text('${mark['weightage']}')),
//                                 DataCell(Text('${mark['obtained_marks']}')),
//                                 DataCell(Text('${mark['total_marks']}')),
//                               ],
//                             );
//                           }).toList()
//                             ..add(DataRow(
//                               cells: [
//                                 DataCell(Text('Total')),
//                                 DataCell(Text(
//                                   '${(sectionData.fold<num>(0, (sum, item) {
//                                     totalWeightageInSection += item['weightage'];
//                                     return sum + item['weightage'];
//                                   })).toStringAsFixed(2)}',
//                                 )),
//                                 DataCell(Text(
//                                   '${(sectionData.fold<num>(0, (sum, item) {
//                                     totalObtainedMarksInSection += (item['obtained_marks'] / item['total_marks']) * item['weightage'];
//                                     return sum + (item['obtained_marks'] / item['total_marks']) * item['weightage'];
//                                   })).toStringAsFixed(2)}',
//                                 )),
//                                 DataCell(Text('')),
//                               ],
//                             )),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//
//             ExpansionTile(
//               title: Text('Grand Total Marks'),
//               children: [
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columns: [
//                       DataColumn(label: Text('Total Marks')),
//                       DataColumn(label: Text('Obtained Marks')),
//                     ],
//                     rows: [
//                       DataRow(
//                         cells: [
//                           DataCell(Text(
//                             '${(totalWeightageInSection).toStringAsFixed(2)}',
//                           )),
//                           DataCell(Text(
//                             '${(totalObtainedMarksInSection).toStringAsFixed(2)}',
//                           )),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: Text('Student Marks'),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          SizedBox(
            width: double.infinity,
            height: 80,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      currentCourse = index;
                    });
                    await calculateTotals();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: currentCourse == index ? tealColor : const Color(
                          0xffB0BEC5),
                      borderRadius: BorderRadius.circular(20),
                      border: currentCourse == index
                          ? Border.all(color: Colors.deepPurpleAccent, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        courses[index],
                        style: TextStyle(
                          color: currentCourse == index
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: courses.isNotEmpty ? sections[courses[currentCourse]]
                  ?.length ?? 0 : 0,
              itemBuilder: (context, sectionIndex) {
                String section = sections[courses[currentCourse]]?[sectionIndex] ??
                    '';
                int rowNumber = 0;

                List<Map<String,
                    dynamic>> sectionData = (marksData[courses[currentCourse]] ??
                    [])
                    .where((data) => data['main_label'] == section)
                    .toList();

                return ExpansionTile(
                  title: Text(section),
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith((
                            states) => tealColor),
                        headingTextStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        columns: [
                          DataColumn(label: Text('$section-#')),
                          DataColumn(label: Text('Weightage')),
                          DataColumn(label: Text('Obtained Marks')),
                          DataColumn(label: Text('Total Marks')),
                        ],
                        rows: sectionData.map<DataRow>((mark) {
                          rowNumber++;
                          return DataRow(
                            cells: [
                              DataCell(Text('${mark['label_index']}')),
                              DataCell(Text('${mark['weightage']}')),
                              DataCell(Text('${mark['obtained_marks']}')),
                              DataCell(Text('${mark['total_marks']}')),
                            ],
                          );
                        }).toList()
                          ..add(DataRow(
                            cells: [
                              DataCell(Text('Total')),
                              DataCell(Text(
                                '${(sectionData.fold<num>(0, (sum, item) {
                                  totalWeightageInSection += item['weightage'];
                                  return sum + item['weightage'];
                                })).toStringAsFixed(2)}',
                              )),
                              DataCell(Text(
                                '${(sectionData.fold<num>(0, (sum, item) {
                                  totalObtainedMarksInSection +=
                                      (item['obtained_marks'] /
                                          item['total_marks']) *
                                          item['weightage'];
                                  return sum + (item['obtained_marks'] /
                                      item['total_marks']) * item['weightage'];
                                })).toStringAsFixed(2)}',
                              )),
                              DataCell(Text('')),
                            ],
                          )),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          ExpansionTile(
            title: Text('Grand Total Marks'),
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith((
                      states) => tealColor),
                  headingTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  columns: [
                    DataColumn(label: Text('Total Marks')),
                    DataColumn(label: Text('Obtained Marks')),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text(
                          '${(totalWeightageInSection).toStringAsFixed(2)}',
                        )),
                        DataCell(Text(
                          '${(totalObtainedMarksInSection).toStringAsFixed(2)}',
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}