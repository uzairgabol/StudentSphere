// import 'package:student_sphere/consts/consts.dart';
// import 'alumni_main.dart';
// import 'package:http/http.dart' as http;
//
// var link = localhostip + "/api/alumni/";
// var link1 = link + "alumnidateupdate.php";
//
// Future<void> _showConfirmedDialog(BuildContext context) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Booking Confirmed'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text('Your booking is confirmed.'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
//
// class AlumniInfo extends StatefulWidget {
//   final AluminiData aluminiData;
//   final String stuId;
//
//   const AlumniInfo({Key? key, required this.aluminiData, required this.stuId}) : super(key: key);
//
//   @override
//   _AlumniInfoState createState() => _AlumniInfoState();
// }
//
// final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
//   minimumSize: Size(327, 50),
//   primary: Color(0xff1B3FAB), // Use 'primary' instead of 'color'
//   elevation: 0,
//   shape: const RoundedRectangleBorder(
//     borderRadius: BorderRadius.all(Radius.circular(50)), // Fix the typo here
//   ),
// );
//
// class _AlumniInfoState extends State<AlumniInfo> {
//   String? selectedDate;
//   String? selectedTime;
//
//   Future<void> updateBooking(String alumniId, String studentId, String date, String time) async {
//
//
//     try {
//       final response = await http.post(
//         Uri.parse(link1),
//         body: {
//           'alumni_id': alumniId,
//           'student_id': studentId,
//           'date': date,
//           'time': time,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         print('Booking updated successfully');
//         // Handle success, if needed
//       } else {
//         print('Error updating booking: ${response.body}');
//         // Handle error
//       }
//     } catch (e) {
//       print('Exception while updating booking: $e');
//       // Handle exception
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Alumni Info'),
//       // ),
//       body:  SingleChildScrollView(
//         padding: EdgeInsets.all(15.0),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 50),
//               CircleAvatar(
//                 radius: 60,
//                 //backgroundImage: AssetImage(widget.aluminiData.imagePath),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 '${widget.aluminiData.name}',
//                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'Degree: ',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black ),
//                     ),
//                     TextSpan(
//                       text: ' ${widget.aluminiData.degree}',
//                       style: TextStyle(fontSize: 16,color: Colors.black ),
//                     ),
//                     TextSpan(text: '\n'), // Add a new line for separation
//                     TextSpan(
//                       text: 'Graduation Year: ',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black ),
//                     ),
//                     TextSpan(
//                       text: ' ${widget.aluminiData.graduationYear}',
//                       style: TextStyle(fontSize: 16,color: Colors.black ),
//                     ),
//                   ],
//                 ),
//               ),
//
//
//               SizedBox(height: 20),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200], // Adjust the shade of grey as needed
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 10),
//                     Text(
//                       'Description:',
//                       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       widget.aluminiData.description ?? "No description available.",
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 30),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200], // Adjust the shade of grey as needed
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Dates and Time Slots:',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 20),
//                     for (var date in widget.aluminiData.dates)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Date: ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(date.date))}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           SizedBox(height: 10),
//                           SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 for (var timeSlot in date.timeSlots)
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                     child:GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           selectedDate = date.date;
//                                           selectedTime = timeSlot.time;
//                                         });
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: (selectedDate == date.date && selectedTime == timeSlot.time)
//                                               ? Color(0xff1B3FAB)
//                                               : Colors.blue.shade400,
//                                           borderRadius: BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.all(12),
//                                         child: Text('${DateFormat('h:mm a').format(DateTime.parse("${date.date} ${timeSlot.time}"))}',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//
//                                   ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 30),
//                         ],
//                       ),
//
//
//                     ElevatedButton(
//                       onPressed: () {
//                         if (selectedDate != null && selectedTime != null) {
//                           _showConfirmationDialog(widget.aluminiData);
//                         } else {
//                           // Show a message that a time slot must be selected
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('Please select a time slot.'),
//                             ),
//                           );
//                         }
//                       },
//                       // style: ButtonStyle(
//                       //   backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1B3FAB)),
//                       //   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(10)),
//                       // ),
//                       style: buttonPrimary,
//                       child: Text(
//                         'Book',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _showConfirmationDialog(AluminiData a) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Booking Confirmation'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Name: ${widget.aluminiData.name}'),
//               Text('Degree: ${widget.aluminiData.degree}'),
//               Text('Graduation Year: ${widget.aluminiData.graduationYear}'),
//               Text('Selected Date: ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(selectedDate!))}'),
//               Text('Selected Time: ${DateFormat('h:mm a').format(DateTime.parse("$selectedDate $selectedTime"))}'),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1B3FAB)),
//               ),
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // Close the confirmation dialog
//                 //  Navigator.of(context).pop();
//
//                 await _showConfirmedDialog(context); // Show the confirmed dialog
//                 await updateBooking(a.alumni_id.toString(), widget.stuId, selectedDate!, selectedTime!);
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => Alumni(stuId: widget.stuId),
//                   ),
//                 );
//                 // Optionally, you can navigate to a success page or perform other actions
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1B3FAB)),
//               ),
//               child: Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_sphere/consts/consts.dart';
import 'package:student_sphere/views/student/home/home.dart';
import 'package:student_sphere/views/student/home_page/home_page.dart';
import 'alumni_main.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/alumni/";
var link1 = link + "alumnidateupdate.php";

Future<void> _showConfirmedDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Booking Confirmed'),
        content: Column(
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 40,
            ),
            SizedBox(height: 10),
            Text(
              'Your booking is confirmed.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: buttonPrimary,
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

class AlumniInfo extends StatefulWidget {
  final AluminiData aluminiData;
  final String stuId;

  const AlumniInfo({Key? key, required this.aluminiData, required this.stuId}) : super(key: key);

  @override
  _AlumniInfoState createState() => _AlumniInfoState();
}

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(327, 50),
  primary: Color(0xff1B3FAB),
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

class _AlumniInfoState extends State<AlumniInfo> {
  String? selectedDate;
  String? selectedTime;

  Future<void> updateBooking(String alumniId, String studentId, String date, String time) async {
    try {
      final response = await http.post(
        Uri.parse(link1),
        body: {
          'alumni_id': alumniId,
          'student_id': studentId,
          'date': date,
          'time': time,
        },
      );

      if (response.statusCode == 200) {
        print('Booking updated successfully');
      } else {
        print('Error updating booking: ${response.body}');
      }
    } catch (e) {
      print('Exception while updating booking: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'Alumni Info',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '${widget.aluminiData.name}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Degree: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: ' ${widget.aluminiData.degree}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Graduation Year: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: ' ${widget.aluminiData.graduationYear}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Description:',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.aluminiData.description ?? "No description available.",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'Dates and Time Slots:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    for (var date in widget.aluminiData.dates)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Date: ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(date.date))}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var timeSlot in date.timeSlots)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedDate = date.date;
                                          selectedTime = timeSlot.time;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: (selectedDate == date.date && selectedTime == timeSlot.time)
                                              ? Color(0xff1B3FAB)
                                              : Colors.blue.shade400,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        padding: EdgeInsets.all(12),
                                        child: Text(
                                          '${DateFormat('h:mm a').format(DateTime.parse("${date.date} ${timeSlot.time}"))}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedDate != null && selectedTime != null) {
                          _showConfirmationDialog(widget.aluminiData);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select a time slot.'),
                            ),
                          );
                        }
                      },
                      style: buttonPrimary,
                      child: Text(
                        'Book',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(AluminiData a) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Booking Confirmation'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${widget.aluminiData.name}'),
              Text('Degree: ${widget.aluminiData.degree}'),
              Text('Graduation Year: ${widget.aluminiData.graduationYear}'),
              Text('Selected Date: ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(selectedDate!))}'),
              Text('Selected Time: ${DateFormat('h:mm a').format(DateTime.parse("$selectedDate $selectedTime"))}'),
            ],
          ),
          actions: [
             // Add spacing between buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: Container(
                    width: 80, // Adjust the width as needed
                    child: Center(
                      child: Text('Cancel'),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () async {
                    await _showConfirmedDialog(context);
                    await updateBooking(a.alumni_id.toString(), widget.stuId, selectedDate!, selectedTime!);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(student_id: widget.stuId),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50), // Set minimum size for the Confirm button
                    backgroundColor: Color(0xff1B3FAB), // Use 'primary' instead of 'color'
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Container(
                    width: 80, // Adjust the width as needed
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
