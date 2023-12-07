import 'package:student_sphere/consts/consts.dart';

Widget containerHeading({required double width, String? title}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.teal, // Match with the theme color
    ),
    width: width,
    height: 40, // Adjusted height for better visibility
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        title!.text.color(whiteColor).fontFamily(bold).size(18).make(), // Adjusted font size
      ],
    ),
  );
}