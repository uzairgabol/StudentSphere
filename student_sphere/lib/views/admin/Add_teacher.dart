import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/admin/";
var link1 = link + "insert_teacher.php";

String hashPassword(String password) {
  // Create a SHA-256 hash
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);

  // Return the hashed password as a hex-encoded string
  return digest.toString();
}

class AddTeacherPage extends StatefulWidget {
  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  TextEditingController teacherIdController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  void saveTeacherDetails() async{
    String teacherId = teacherIdController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String password = passwordController.text;
    String phoneNumber = phoneNumberController.text;
    String address = addressController.text;
    String email = emailController.text;
    String registrationNumber = registrationNumberController.text;
    String dateOfBirth = dateOfBirthController.text;
    String degree = degreeController.text;
    String specialization = specializationController.text;
    String experience = experienceController.text;
    String age = ageController.text;
    String department = departmentController.text;

    // Validation: Check if any of the fields is empty
    if (teacherId.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        password.isEmpty ||
        phoneNumber.isEmpty ||
        address.isEmpty ||
        email.isEmpty ||
        registrationNumber.isEmpty ||
        dateOfBirth.isEmpty ||
        degree.isEmpty ||
        specialization.isEmpty ||
        experience.isEmpty ||
        age.isEmpty ||
        department.isEmpty) {
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

    // Validation: Check if teacherId exceeds the maximum length
    int maxTeacherIdLength = 4; // Set your maximum length here
    if (teacherId.length > maxTeacherIdLength) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Teacher ID cannot exceed $maxTeacherIdLength characters."),
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
      return; // Stop execution if teacherId exceeds the maximum length
    }



    bool confirmResult = await showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: Text("Confirmation"),
    content: Text(
        "Are you sure you want to save these details?\n\nTeacher ID: $teacherId\nFirst Name: $firstName\nLast Name: $lastName\nPassword: $password\nPhone Number: $phoneNumber\nAddress: $address\nEmail: $email\nRegistration Number: $registrationNumber\nDate of Birth: $dateOfBirth\nDegree: $degree\nSpecialization: $specialization\nYears of Experience: $experience\nAge: $age\nDepartment: $department"),
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
    'teacher_id': teacherId,
    'first_name': firstName,
    'last_name': lastName,
    'department': department,
    'degree': degree,
    'address': address,
    'registerNumber': registrationNumber,
    'dateOfBirth': dateOfBirth,
    'email': email,
    'phoneNumber': phoneNumber,
    'hashed_password': hashPassword(password),
      'specialization': specialization,
      'yearsOfExperience': experience,
      'age': age
    };

    log(data.toString());
    try {
    var response = await http.post(Uri.parse(link1), body: data);
    log(response.body);
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
        title: Text("Add Teacher"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField("Teacher ID", teacherIdController),
              SizedBox(height: 10),
              _buildTextField("First Name", firstNameController),
              SizedBox(height: 10),
              _buildTextField("Last Name", lastNameController),
              SizedBox(height: 10),
              _buildTextField("Password", passwordController, obscureText: true),
              SizedBox(height: 10),
              _buildTextField("Phone Number", phoneNumberController, keyboardType: TextInputType.phone),
              SizedBox(height: 10),
              _buildTextField("Address", addressController),
              SizedBox(height: 10),
              _buildTextField("Email", emailController, keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10),
              _buildTextField("Registration Number", registrationNumberController),
              SizedBox(height: 10),
              _buildTextField("Date of Birth", dateOfBirthController),
              SizedBox(height: 10),
              _buildTextField("Degree", degreeController),
              SizedBox(height: 10),
              _buildTextField("Specialization", specializationController),
              SizedBox(height: 10),
              _buildTextField("Years of Experience", experienceController),
              SizedBox(height: 10),
              _buildTextField("Age", ageController),
              SizedBox(height: 10),
              _buildTextField("Department", departmentController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveTeacherDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child:const Text(
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
      ),
    );
  }
}
