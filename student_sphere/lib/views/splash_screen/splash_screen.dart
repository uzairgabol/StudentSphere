import 'package:student_sphere/consts/consts.dart';
import 'package:student_sphere/views/authentication_screen/login_screen/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(
        const Duration(seconds: 3),(){
      Get.to(()=> LoginPage());
    }
    );
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgLogo)
          ],
        ),
      ),
    );
  }
}
