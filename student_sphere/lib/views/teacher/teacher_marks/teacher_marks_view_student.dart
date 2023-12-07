import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/students/";
var link1 = link + "courses.php";
var link2 = link + "getmarksstructure.php";
var link3 = link + "getmarks.php";

class TeacherStudentMarks extends StatefulWidget {
  final String tId;
  final String studentId;
  final String courseId;

  TeacherStudentMarks({
    required this.tId,
    required this.studentId,
    required this.courseId,
  });

  @override
  _TeacherStudentMarksState createState() => _TeacherStudentMarksState();
}

class _TeacherStudentMarksState extends State<TeacherStudentMarks> {
  List<String> sections = [];
  List<Map<String, dynamic>> marksData = [];
  double grandTotalWeightage = 0;
  double grandTotalObtainedMarks = 0;
  num totalWeightageInSection = 0;
  num totalObtainedMarksInSection = 0;

  @override
  void initState() {
    super.initState();
    // Fetch sections and marks for the provided studentId and courseId
    fetchSectionsForCourse(widget.courseId);
    fetchMarksForCourse(widget.courseId);
  }

  Future<void> fetchSectionsForCourse(String courseId) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {'student_id': widget.studentId, 'course_id': courseId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is Map<String, dynamic>) {
          setState(() {
            sections = List<String>.from(jsonResponse[courseId] ?? []);
          });
        } else {
          print('Unexpected response format for sections: $jsonResponse');
        }
      } else {
        print('Failed to load sections for $courseId. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchMarksForCourse(String courseId) async {
    try {
      final response = await http.post(
        Uri.parse(link3),
        body: {'student_id': widget.studentId, 'course_id': courseId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            marksData = jsonResponse.map((mark) {
              return {
                'label_index': num.tryParse(mark['label_index']?.toString() ?? '0') ?? 0,
                'weightage': num.tryParse(mark['weightage']?.toString() ?? '0') ?? 0,
                'obtained_marks': mark['obtained_marks'] != null
                    ? num.tryParse(mark['obtained_marks'].toString()) ?? null
                    : null,
                'total_marks': num.tryParse(mark['total_marks']?.toString() ?? '0') ?? 0,
                'main_label': mark['main_label']?.toString() ?? '',
              };
            }).toList();
          });
        } else {
          print('Unexpected response format for marks: $jsonResponse');
        }
      } else {
        print('Failed to load marks for $courseId. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    calculateTotals();
  }


  Future<void> calculateTotals() async {
    totalWeightageInSection = 0;
    totalObtainedMarksInSection = 0;

    // Calculate total weightage and obtained marks for the current section
    marksData.forEach((item) {
      totalWeightageInSection += item['weightage'];
      totalObtainedMarksInSection +=
          (item['obtained_marks'] ?? 0) / item['total_marks'] * item['weightage'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: Text('Student Marks ${widget.studentId}'),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: sections.length,
                itemBuilder: (context, sectionIndex) {
                  String section = sections[sectionIndex] ?? '';
                  int rowNumber = 0;

                  List<Map<String, dynamic>> sectionData = (marksData ?? [])
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
                                DataCell(Text('${mark['obtained_marks'] != null ? mark['obtained_marks'] : "-"}')),
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
                                    var obtainedMarks = item['obtained_marks'] ?? 0;
                                    totalObtainedMarksInSection +=
                                        (obtainedMarks  /
                                            item['total_marks']) *
                                            item['weightage'];
                                    return sum + (obtainedMarks /
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
