import 'package:student_sphere/consts/consts.dart';
import 'package:student_sphere/views/admin/UnenrollStudent.dart';
import 'package:student_sphere/views/admin/enroll_student.dart';

class ManageEnrollmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        centerTitle: true,
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
              SizedBox(height: 40),
              _buildEnrollmentCard(
                context,
                'Enroll Student',
                'EnrollStudent',
                Colors.green,
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              _buildEnrollmentCard(
                context,
                'Unenroll Student',
                'UnenrollStudent',
                Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnrollmentCard(
      BuildContext context,
      String label,
      String action,
      Color color,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to the specific enrollment action page based on the selected option
          if (action == 'EnrollStudent') {
            Get.to(EnrollStudentPage());
          }else if (action == 'UnenrollStudent') {
            // Add logic for UnenrollStudent page navigation
            Get.to(UnenrollStudentPage());
          }
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.assignment,
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
