import 'package:student_sphere/consts/consts.dart';
import 'remove_course.dart';
import 'remove_student.dart';
import 'remove_teacher.dart';

class remove extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Select an option',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              //SizedBox(height: 20),

              SizedBox(height: 40),
              _buildProfessionalCard(
                context,
                Icons.person_remove,
                'Remove Student',
                Colors.green,
              ),
              SizedBox(height: 20),
              _buildProfessionalCard(
                context,
                Icons.school,
                'Remove Teacher',
                Colors.teal,
              ),
              SizedBox(height: 20),
              _buildProfessionalCard(
                context,
                Icons.book,
                'Remove Course',
                Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfessionalCard(
      BuildContext context,
      IconData icon,
      String label,
      Color color,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          if (label == 'Remove Student') {
            Get.to(RemoveStudentPage());
          } else if (label == 'Remove Teacher') {
            Get.to(RemoveTeacherPage());
          } else if (label == 'Remove Course') {
            Get.to(RemoveCoursePage());
          }
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 50,
                color: color,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
