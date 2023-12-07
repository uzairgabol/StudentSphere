import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/teachers/attendance/";
var link1 = link + "teachergetstudent.php";
var link2 = link + "teacheraddmarks.php";
var link3 = link + "teacherupdatemarks.php";

class TeacherAddMarksStudent extends StatefulWidget {
  final String teacherId;
  final String course;
  final String section;
  final String label;
  final int index;
  final double weightage;
  final double totalMarks;

  const TeacherAddMarksStudent({
    required this.teacherId,
    required this.course,
    required this.section,
    required this.label,
    required this.index,
    required this.weightage,
    required this.totalMarks,
  });

  @override
  State<TeacherAddMarksStudent> createState() =>
      _TeacherAddMarksStudentState();
}

class _TeacherAddMarksStudentState extends State<TeacherAddMarksStudent> {
  List<Map<String, dynamic>> studentData = [];

  @override
  void initState() {
    super.initState();
    // Fetch student data first
    fetchMarksData(widget.teacherId, widget.course, widget.section).then((_) {
      // After student data is fetched, insert marks for each student
      for (int i = 0; i < studentData.length; i++) {
        insertMarks(
            widget.index,
            widget.label,
            widget.weightage,
            widget.totalMarks,
            widget.course,
            widget.teacherId,
            studentData[i]['student_id']
        );
      }
    });
  }


  bool flag = true;

  Future<void> saveMarks() async {
    for (int i = 0; i < studentData.length; i++) {
      await updateMarks(
        widget.index,
        widget.label,
        widget.weightage,
        widget.totalMarks,
        widget.course,
        widget.teacherId,
        studentData[i]['student_id'],
        studentData[i]['obtained_marks'],
      );
    }
    if(flag){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Marks saved successfully.'),
        ),
      );

      Get.back();
      Get.back();
    }
    else{
      flag = true;
    }

  }


  Future<void> fetchMarksData(
      String teacherID, String courseId, String section) async {
    try {
      final response = await http.post(
        Uri.parse(link1),
        body: {
          'teacher_id': teacherID,
          'course_id': courseId,
          'section': section,
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            studentData =
            List<Map<String, dynamic>>.from(jsonResponse);
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
        print(
            'Failed to load marks data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> insertMarks(
      int indexlabel,
      String mainlabel,
      double weightage,
      double totalmarks,
      String courseId,
      String teacherId,
      String studentId,
      ) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {
          'label_index': indexlabel.toString(),
          'weightage': weightage.toString(),
          'total_marks': totalmarks.toString(),
          'main_label': mainlabel,
          'course_id': courseId,
          'teacher_id': teacherId,
          'student_id': studentId,
        },
      );

      if (response.statusCode == 200) {
        print("Marks data inserted successfully");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updateMarks(
      int indexlabel,
      String mainlabel,
      double weightage,
      double totalmarks,
      String courseId,
      String teacherId,
      String studentId,
      double obtainedmarks,
      ) async {
    try {
      final response = await http.post(
        Uri.parse(link3),
        body: {
          'label_index': indexlabel.toString(),
          'weightage': weightage.toString(),
          'total_marks': totalmarks.toString(),
          'main_label': mainlabel,
          'course_id': courseId,
          'teacher_id': teacherId,
          'student_id': studentId,
          'obtained_marks': obtainedmarks.toString(),
        },
      );

      if (response.statusCode == 200) {
        if (response.body.contains("Marks data updated successfully")) {
          print("Marks updated successfully for student $studentId");
        }
        else {
          print("Error: ${response.statusCode} - ${response.body}");
          final dynamic jsonResponse = json.decode(response.body);
          flag = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(jsonResponse + " <= ${totalmarks}"),
            ),
          );
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Marks"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeadingRow(),
            _buildStudentDataList(),
            SizedBox(height: 16),

            // "Save" button
            _buildSaveButton(),
          ],
        ),
      ),
    );

  }

  Widget _buildHeadingRow() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.teal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildHeadingText('S.no'),
          SizedBox(width: 16),
          _buildHeadingText('Student_id'),
          SizedBox(width: 16),
          _buildHeadingText('Obtained Marks'),
        ],
      ),
    );
  }

  Widget _buildHeadingText(String text) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildStudentDataList() {
    return Expanded(
      child: ListView.builder(
        itemCount: studentData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDataText("${index + 1}", flex: 2),
                SizedBox(width: 16),
                _buildDataText(studentData[index]['student_id'], flex: 4),
                SizedBox(width: 16),
                _buildObtainedMarksTextField(index),
              ],
            ),
          );
        },
      ),
    );
  }



  Widget _buildDataText(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildObtainedMarksTextField(int index) {
    return Container(
      width: 120,
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            double obtainedMarks = double.tryParse(value) ?? 0.0;
            setState(() {
              studentData[index]['obtained_marks'] = obtainedMarks;
              // updateMarks(
              //   widget.index,
              //   widget.label,
              //   widget.weightage,
              //   widget.totalMarks,
              //   widget.course,
              //   widget.teacherId,
              //   studentData[index]['student_id'],
              //   obtainedMarks,
              // );
            });
          },
        ),
      ),
    );
  }
  Widget _buildSaveButton() {
    return Builder(
      builder: (context) => ElevatedButton(
        onPressed: () {
          saveMarks();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


