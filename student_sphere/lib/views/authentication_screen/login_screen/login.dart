import 'package:flutter/material.dart';
import 'package:student_sphere/component/my_button.dart';
import 'package:student_sphere/component/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:student_sphere/consts/consts.dart';
import 'package:student_sphere/views/admin/admin_nav.dart';
import 'package:student_sphere/views/student/home_page/home_page.dart';
import 'package:student_sphere/views/teacher/home_page/teacher_home.dart';
// import 'package:student_sphere/pages/home_page.dart';

var link;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}


// text editing controllers
final IPController = TextEditingController();
final usernameController = TextEditingController();
final passwordController = TextEditingController();
TextEditingController ipAddressController = TextEditingController();
//
// void _showIpAddressDialog(BuildContext context) {
//
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Enter IP Address'),
//         content: TextField(
//           controller: ipAddressController,
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(labelText: '192.xxx.x.xxx'),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               String ipAddress = ipAddressController.text;
//               localhostip = "http://" + ipAddress;
//               link = localhostip + "/api/students/login.php";
//               print('Entered IP Address: $localhostip');
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }

void _showIpAddressDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter IP Address'),
        content: TextField(
          controller: ipAddressController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(labelText: '192.xxx.x.xxx'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String ipAddress = ipAddressController.text;
              localhostip = "http://" + ipAddress;
              link = localhostip + "/api/students/login.php";
              Navigator.of(context).pop(); // Close the dialog

              //Use pushReplacement to clear previous routes
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    //Navigator.pop(context);
  }

  void signUserIn(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
    if(_userType == 'student'){
      print(hashPassword(passwordController.text));
      loginUserStudent();
    }
    else if(_userType == 'teacher'){
      loginUserTeacher();
    }
    else{
      loginUserAdmin();
    }
  }
  String hashPassword(String password) {
    // Create a SHA-256 hash
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);

    // Return the hashed password as a hex-encoded string
    return digest.toString();
  }
  void errorInfo(context){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Incorrect Credentials'),
        );
      },
    );
  }

  loginUserAdmin() async{
    try{
      link = localhostip + "/api/admin/login.php";
      var res = await http.post(
        Uri.parse(link),
        body: {
          'id' : usernameController.text.trim(),
          'password' : hashPassword(passwordController.text.trim()),
        },
      );
      print(link);
      if(res.statusCode == 200){
        String stuId = usernameController.text;
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin["success"] == "true"){
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.pop(context);
          Navigator.pop(context);
          Get.to(()=> admin_nav());
        }
        else{
          Fluttertoast.showToast(msg: "Invalid login credentials!");
        }
      }
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: "Connection Error");
    }
  }

  loginUserStudent() async{
    try{
      var res = await http.post(
        Uri.parse(link),
        body: {
          'id' : usernameController.text.trim(),
          'password' : hashPassword(passwordController.text.trim()),
        },
      );
      print(link);
      if(res.statusCode == 200){
        String stuId = usernameController.text;
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin["success"] == "true"){
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.pop(context);
          Navigator.pop(context);
          Get.to(()=> HomePage(student_id: stuId));
        }
        else{
          Fluttertoast.showToast(msg: "Invalid login credentials!");
        }
      }
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: "Connection Error");
    }
  }

  loginUserTeacher() async{
    try{
      link = localhostip + "/api/teachers/teacher_login.php";
      var res = await http.post(
        Uri.parse(link),
        body: {
          'teacher_id' : usernameController.text.trim(),
          'password' : hashPassword(passwordController.text.trim()),
        },
      );
      print(link);
      if(res.statusCode == 200){
        String tId = usernameController.text;
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin["success"] == "true"){
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.pop(context);
          Navigator.pop(context);
          Get.to(()=> TeacherHomePage(teacher_id: tId));
        }
        else{
          Fluttertoast.showToast(msg: "Invalid login credentials!");
        }
      }
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: "Connection Error");
    }
  }


  String _userType = 'student';// default after selecting will store in this variable
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0Xfff5f5f5),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 40),
//
//                 Center(
//                   child: Container(
//                     width: 250,
//                     height: 250,
//                     child: Image.asset(imgLogo),
//                   ),
//                 ),
//
//                 //const SizedBox(height: 10),
//
//                 // welcome back!
//                 Text(
//                   'Welcome',
//                   style: TextStyle(
//                     color: Colors.grey[700],
//                     fontSize: 18,
//                   ),
//                 ),
//
//
//                 const SizedBox(height: 25),
//
//                 // username textfield
//                 MyTextField(
//                   controller: usernameController,
//                   hintText: 'Username',
//                   obscureText: false,
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // password textfield
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   obscureText: true,
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     children: [
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                         child: Row(
//                           children: [
//                             Radio(
//                               value: 'student',
//                               groupValue: _userType,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _userType = value.toString();
//                                 });
//                               },
//                             ),
//                             Text('Student'),
//                           ],
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                         child: Row(
//                           children: [
//                             Radio(
//                               value: 'teacher',
//                               groupValue: _userType,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _userType = value.toString();
//                                 });
//                               },
//                             ),
//                             Text('Teacher'),
//                           ],
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 // sign in button
//                 const SizedBox(height: 10),
//                 MyButton(
//                   onTap: () {
//                     print(hashPassword(passwordController.text));
//                     signUserIn(context);
//                   },
//                   //onTap: signUserIn,
//                 ),
//
//                 const SizedBox(height: 50),
//
//
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                       //use IPaddress
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: TextButton(
//                           // style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.grey[600]),),
//                           child: Text('Use IP address?',style:TextStyle(color: Colors.grey[600]), ),
//                           onPressed: (){
//                             _showIpAddressDialog(context);
//                           },
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 50),
//
//
//                 const SizedBox(height: 50),
//
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgLogo),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 25),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 'admin',
                      groupValue: _userType,
                      onChanged: (value) {
                        setState(() {
                          _userType = value.toString();
                        });
                      },
                    ),
                    Text('Admin'),
                    Radio(
                      value: 'student',
                      groupValue: _userType,
                      onChanged: (value) {
                        setState(() {
                          _userType = value.toString();
                        });
                      },
                    ),
                    Text('Student'),
                    SizedBox(width: 20),
                    Radio(
                      value: 'teacher',
                      groupValue: _userType,
                      onChanged: (value) {
                        setState(() {
                          _userType = value.toString();
                        });
                      },
                    ),
                    Text('Teacher'),
                  ],
                ),
                SizedBox(height: 20),
                MyButton(
                  onTap: () {
                    signUserIn(context);
                  },
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextButton(
                        child: Text(
                          'Use IP address?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        onPressed: () {
                          _showIpAddressDialog(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
