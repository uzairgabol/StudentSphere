import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/admin/";
var link1 = link + "insert_student.php";

class StudentDetailsPage extends StatefulWidget {
  @override
  _StudentDetailsPageState createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController campusController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();


  String hashPassword(String password) {
    // Create a SHA-256 hash
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);

    // Return the hashed password as a hex-encoded string
    return digest.toString();
  }

  void saveStudentDetails() async{
    String id = idController.text;
    String password = passwordController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String section = sectionController.text;
    String degree = degreeController.text;
    String campus = campusController.text;
    String status = statusController.text;
    String gender = genderController.text;
    String dob = dobController.text;
    String email = emailController.text;
    String nationality = nationalityController.text;
    String phoneNumber = phoneNumberController.text;

    // Validation: Check if any of the fields is empty
    if (id.isEmpty ||
        password.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        section.isEmpty ||
        degree.isEmpty ||
        campus.isEmpty ||
        status.isEmpty ||
        gender.isEmpty ||
        dob.isEmpty ||
        email.isEmpty ||
        nationality.isEmpty ||
        phoneNumber.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in all fields."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return; // Stop execution if there are empty fields
    }

    int maxStudentIdLength = 8; // Set your maximum length here
    if (id.length > maxStudentIdLength) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Student ID cannot exceed $maxStudentIdLength characters."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return; // Stop execution if student ID exceeds the maximum length
    }
    log("1");
    // Display confirmation
    // Display confirmation
    bool confirmResult = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text(
              "Are you sure you want to save these details?\n\nID: $id\nPassword: $password\nFirst Name: $firstName\nLast Name: $lastName\nSection: $section\nDegree: $degree\nCampus: $campus\nStatus: $status\nGender: $gender\nDOB: $dob\nEmail: $email\nNationality: $nationality\nPhone Number: $phoneNumber"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
    log(confirmResult.toString());
    if (confirmResult != true) {
      return; // User canceled the operation
    }
    log("2");

    Map<String, String> data = {
      'student_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'section': section,
      'degree': degree,
      'campus': campus,
      'status': status,
      'gender': gender,
      'dob': dob,
      'email': email,
      'nationality': nationality,
      'phone': phoneNumber,
      'hashed_password': hashPassword(password),
    };

  log(data.toString());
    try {
      var response = await http.post(Uri.parse(link1), body: data);

      if (response.statusCode == 200) {
        _showSuccessDialog();
      } else {
        // If the server returns an error response, show error snackbar
        _showSnackbar("Failed to save details. Please try again.", Colors.red);
      }
    } catch (e) {
      // Handle exceptions (e.g., network error) and show error snackbar
      print("Error: $e");
      _showSnackbar("An error occurred. Please try again.", Colors.red);
    }
  }

  void _showSnackbar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }



  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Details saved successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.back();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Add Student"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField("ID", idController),
              SizedBox(height: 10),
              _buildTextField("Password", passwordController, obscureText: true),
              SizedBox(height: 10),
              _buildTextField("First Name", firstNameController),
              SizedBox(height: 10),
              _buildTextField("Last Name", lastNameController),
              SizedBox(height: 10),
              _buildTextField("Section", sectionController),
              SizedBox(height: 10),
              _buildTextField("Degree", degreeController),
              SizedBox(height: 10),
              _buildTextField("Campus", campusController),
              SizedBox(height: 10),
              _buildTextField("Status", statusController),
              SizedBox(height: 10),
              _buildTextField("Gender", genderController),
              SizedBox(height: 10),
              _buildTextField("DOB", dobController),
              SizedBox(height: 10),
              _buildTextField("Email", emailController, keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10),
              _buildTextField("Nationality", nationalityController),
              SizedBox(height: 10),
              _buildTextField("Phone Number", phoneNumberController, keyboardType: TextInputType.phone),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveStudentDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "Save Details",
                  style: TextStyle(fontSize: 16),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType, bool obscureText = false}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
    //    border: OutlineInputBorder(),
      ),
    );
  }
}
