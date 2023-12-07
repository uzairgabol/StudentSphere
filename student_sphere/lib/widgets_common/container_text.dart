import 'package:student_sphere/consts/consts.dart';

Widget containerText({String? title1, String? title2}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      title1!.text.color(Colors.black).size(16).fontFamily(bold).make(),
      // Adjusted font size
      10.widthBox,
      // Increased spacing
      title2!.text.color(secondaryTextColor).fontFamily(regular)
          .size(16)
          .make(),
      // Adjusted font size
    ],
  );
}