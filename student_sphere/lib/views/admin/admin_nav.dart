import 'package:student_sphere/consts/consts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:modernlogintute/Admin/Add_course.dart';
// import 'package:modernlogintute/Admin/Add_student.dart';
// import 'package:modernlogintute/Admin/Add_teacher.dart';
import 'package:student_sphere/views/admin/AdminHomePage.dart';
import 'package:student_sphere/views/admin/Remove.dart';
import 'package:student_sphere/views/admin/add.dart';
import 'package:student_sphere/views/admin/enroll.dart';

int _pageIndex = 0;
class admin_nav extends StatefulWidget {
  const admin_nav({Key? key}) : super(key: key);

  @override
  _AdminNavState createState() => _AdminNavState();
}

class _AdminNavState extends State<admin_nav> {

  final List<Widget> _pages = [
   // Home(),
    add(),
    ManageEnrollmentsPage(),
    remove(),
    // add_course(),
    // AddStudentPage(),
    // AddTeacherPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home Page'),
      // ),
      body: _pages[_pageIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
            padding: EdgeInsets.all(16),
            tabs: const [
              // GButton(
              //   icon: Icons.home,
              //   text: 'Home',
              // ),
              GButton(
                icon: Icons.add,
                text: 'Add',
               ),
              GButton(
                icon: Icons.grade,
                text: 'Enroll',
              ),
              GButton(
                icon: Icons.remove,
                text: 'Remove',
              ),
              // GButton(
              //   icon: Icons.network_cell_rounded,
              //   text: 'Alumini',
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This is the content for the "Home" tab
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Welcome to the Home Page"),
          ElevatedButton(
            onPressed: () {
              // Sign Out button action
              // Add your sign-out logic here
              // For example, you can show a dialog for confirmation and sign the user out.
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => LoginPage(),
              //   ),
              // );
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}