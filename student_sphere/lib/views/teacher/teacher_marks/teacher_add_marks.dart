import 'teacher_add_marks_student.dart';
import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/teachers/attendance/";
var link1 = link + "teachergetcourse.php";
var link2 = link + "teachergetsection.php";
var link3 = link + "getlabelmarks.php";

class TeacherAddMarksEdit extends StatefulWidget {
  final String tId;
  const TeacherAddMarksEdit({super.key, required this.tId});

  @override
  State<TeacherAddMarksEdit> createState() => _TeacherAddMarksEditState();
}

class _TeacherAddMarksEditState extends State<TeacherAddMarksEdit> {
  String? selectedCourse;
  String? selectedSection;
  String? selectedLabel;
  String? newLabel;
  int? newIndex;
  double? newWeightage;
  double? newTotalMarks;
  List<String> courses = [];
  List<String> sections = [];
  List<String> labels = [];
  bool isLabelSelectedFromDropdown = false;
  final FocusNode newLabelFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  void dispose() {
    // Dispose of the FocusNode when it's no longer needed
    newLabelFocusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchCourses() async {
    try {
      final response = await http.post(
        Uri.parse(link1),
        body: {'teacher_id': widget.tId},
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

  Future<void> _fetchSections(String courseId) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {'teacher_id': widget.tId, 'course_id': courseId},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            sections = List<String>.from(jsonResponse);
          });
        } else {
          print('Unexpected response format: $jsonResponse');
        }
      } else {
        print('Failed to load sections. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchLabels(String courseId, String section) async {
    try {
      final response = await http.post(
        Uri.parse(link3),
        body: {'teacher_id': widget.tId, 'course_id': courseId, 'section': section},
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List<dynamic>) {
          setState(() {
            labels = List<String>.from(jsonResponse);
          });
        } else {
          print('Unexpected response format: $jsonResponse');
        }
      } else {
        print('Failed to load labels. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Marks"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown(
                value: selectedCourse,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCourse = newValue!;
                    _fetchSections(newValue!);
                    selectedSection = null;
                    selectedLabel = null;
                    labels.clear();
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
                    _fetchLabels(selectedCourse!, newValue!);
                    selectedLabel = null;
                    labels.clear();
                  });
                },
                items: sections,
                labelText: 'Select Section',
              ),
              _buildLabelDropdown(),
              _buildNewLabelTextField(),
              _buildIndexTextField(),
              _buildWeightageTextField(),
              _buildTotalMarksTextField(),
              _buildNextButton(context),
            ],
          ),
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

  Widget _buildLabelDropdown() {
    return DropdownButton<String>(
      value: selectedLabel,
      onChanged: (String? newValue) {
        setState(() {
          selectedLabel = newValue!;
          newLabel = null;
          isLabelSelectedFromDropdown = false;
        });
      },
      items: labels.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text('Select Label'),
    );
  }

  // Widget _buildLabelDropdown() {
  //   return DropdownButton<String>(
  //     value: selectedLabel,
  //     onChanged: (String? newValue) {
  //       setState(() {
  //         selectedLabel = newValue!;
  //         newLabel = null;
  //         isLabelSelectedFromDropdown = false;
  //       });
  //     },
  //     items: labels.map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //     hint: Text('Select Label'),
  //   );
  // }

  // Widget _buildNewLabelTextField() {
  //   return TextFormField(
  //     enabled: newLabel == null,
  //     onChanged: (value) {
  //       setState(() {
  //         newLabel = value;
  //         selectedLabel = null;
  //         isLabelSelectedFromDropdown = true;
  //       });
  //     },
  //     decoration: InputDecoration(
  //       labelText: 'New Label',
  //     ),
  //   );
  // }

  Widget _buildNewLabelTextField() {
    return TextFormField(
      enableInteractiveSelection: true,
      onTap: () {
        if (isLabelSelectedFromDropdown) {
          // Clear the text when tapped if label is selected from dropdown
          setState(() {
            newLabel = '';
          });
        }
      },
      onChanged: (value) {
        setState(() {
          newLabel = value;
          selectedLabel = null;
          isLabelSelectedFromDropdown = true;
        });
      },
      decoration: InputDecoration(
        labelText: 'New Label',
      ),
    );
  }


  void _onNewLabelChanged(String value) {
    setState(() {
      newLabel = value;
      selectedLabel = null;
      isLabelSelectedFromDropdown = true;
    });
  }


  Widget _buildIndexTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          newIndex = int.tryParse(value);
        });
      },
      decoration: InputDecoration(
        labelText: 'Index',
      ),
    );
  }

  Widget _buildWeightageTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          newWeightage = double.tryParse(value);
        });
      },
      decoration: InputDecoration(
        labelText: 'Weightage',
      ),
    );
  }

  Widget _buildTotalMarksTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          newTotalMarks = double.tryParse(value);
        });
      },
      decoration: InputDecoration(
        labelText: 'Total Marks',
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

  void _onNextClicked(BuildContext context) {
    if (selectedCourse == null ||
        selectedSection == null ||
        (selectedLabel == null && newLabel == null) ||
        newIndex == null ||
        newWeightage == null ||
        newTotalMarks == null) {
      // Show error if any field is missing
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    } else {
      // Navigate to the next page with the selected values
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>
            Get.to(TeacherAddMarksStudent(
            course: selectedCourse!,
            section: selectedSection!,
            label: selectedLabel ?? newLabel!,
            index: newIndex!,
            weightage: newWeightage!,
            totalMarks: newTotalMarks!,
            teacherId: widget.tId,
          ),
        );
      // );
    }
  }
}
