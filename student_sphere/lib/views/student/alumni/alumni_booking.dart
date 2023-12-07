// import 'package:student_sphere/consts/consts.dart';
// import 'package:http/http.dart' as http;
//
// var link = localhostip + "/api/alumni/";
// var link1 = link + "alumnigetbookings.php";
// var link2 = link + "alumnidelbooking.php";
//
// class BookedSlot {
//   final String alumniId;
//   final String alumniName;
//   final String selectedDate;
//   final String selectedTime;
//
//   BookedSlot({
//     required this.alumniId,
//     required this.alumniName,
//     required this.selectedDate,
//     required this.selectedTime,
//   });
// }
//
// class BookedSlotsPage extends StatefulWidget {
//   final String stuId;
//   const BookedSlotsPage({Key? key, required this.stuId});
//
//   @override
//   _BookedSlotsPageState createState() => _BookedSlotsPageState();
// }
//
// class _BookedSlotsPageState extends State<BookedSlotsPage> {
//   List<BookedSlot> bookedSlots = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData().then((_) {
//       print(bookedSlots);
//     });
//   }
//
//   Future<void> fetchData() async {
//     final response = await http.post(
//       Uri.parse(link1),
//       body: {'student_id': widget.stuId},
//     );
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       setState(() {
//         bookedSlots = data.map((item) => BookedSlot(
//           alumniId: item['alumni_id'],
//           alumniName: item['alumni_name'],
//           selectedDate: item['date'],
//           selectedTime: item['time'],
//         )).toList();
//       });
//     } else {
//       // Handle error
//       print('Failed to load booked slots data');
//     }
//   }
//
//   Future<void> updateAlumniStatus(
//       String alumniId,
//       String date,
//       String time,
//       ) async {
//     try {
//       final response = await http.post(
//         Uri.parse(link2),
//         body: {
//           'alumni_id': alumniId,
//           'date': date,
//           'time': time,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         print('Alumni status updated successfully');
//       } else {
//         print(
//             'Failed to update alumni status. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error updating alumni status: $error');
//     }
//   }
//
//   final List<Color> aluminiColors = [
//     Colors.blue.shade100,
//     Colors.orange.shade100,
//     Colors.teal.shade100,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointments'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.cancel),
//             onPressed: () {
//               // Show cancel confirmation dialog using GetX
//               Get.defaultDialog(
//                 title: 'Cancel All Appointments?',
//                 content:
//                 Text('Are you sure you want to cancel all the appointments?'),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: Text('No'),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       // Loop through all booked slots and update alumni status
//                       for (var index = 0; index < bookedSlots.length; index++) {
//                         await updateAlumniStatus(
//                           bookedSlots[index].alumniId,
//                           bookedSlots[index].selectedDate,
//                           bookedSlots[index].selectedTime,
//                         );
//                       }
//
//                       // Clear the booked slots list
//                       setState(() {
//                         fetchData();
//                       });
//                       Get.back();
//                     },
//                     child: Text('Yes'),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Expanded(
//               child: Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ListView.builder(
//                     itemCount: bookedSlots.length,
//                     itemBuilder: (context, index) {
//                       final Color aluminiColor =
//                       aluminiColors[index % aluminiColors.length];
//
//                       return Card(
//                         elevation: 3,
//                         margin: EdgeInsets.symmetric(vertical: 10),
//                         color: aluminiColor,
//                         child: ListTile(
//                           title: Text(
//                             'Alumni Name: ${bookedSlots[index].alumniName}',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   'Selected Date: ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(bookedSlots[index].selectedDate!))}'),
//                               Text(
//                                   'Selected Time: ${DateFormat('h:mm a').format(DateTime.parse("${bookedSlots[index].selectedDate} ${bookedSlots[index].selectedTime}"))}'),
//                             ],
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.remove),
//                             onPressed: () {
//                               Get.defaultDialog(
//                                 title: 'Cancel the Selected Appointment?',
//                                 content: Text(
//                                   'Are you sure you want to cancel the selected appointment?',
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Get.back();
//                                     },
//                                     child: Text('No'),
//                                   ),
//                                   TextButton(
//                                     onPressed: () async {
//                                       await updateAlumniStatus(
//                                         bookedSlots[index].alumniId,
//                                         bookedSlots[index].selectedDate,
//                                         bookedSlots[index].selectedTime,
//                                       );
//
//                                       setState(() {
//                                         fetchData();
//                                       });
//                                       Get.back();
//                                     },
//                                     child: Text('Yes'),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:student_sphere/consts/consts.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/alumni/";
var link1 = link + "alumnigetbookings.php";
var link2 = link + "alumnidelbooking.php";

class BookedSlot {
  final String alumniId;
  final String alumniName;
  final String selectedDate;
  final String selectedTime;

  BookedSlot({
    required this.alumniId,
    required this.alumniName,
    required this.selectedDate,
    required this.selectedTime,
  });
}

class BookedSlotsPage extends StatefulWidget {
  final String stuId;
  const BookedSlotsPage({Key? key, required this.stuId});

  @override
  _BookedSlotsPageState createState() => _BookedSlotsPageState();
}

class _BookedSlotsPageState extends State<BookedSlotsPage> {
  List<BookedSlot> bookedSlots = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((_) {
      print(bookedSlots);
    });
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse(link1),
      body: {'student_id': widget.stuId},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        bookedSlots = data.map((item) => BookedSlot(
          alumniId: item['alumni_id'],
          alumniName: item['alumni_name'],
          selectedDate: item['date'],
          selectedTime: item['time'],
        )).toList();
      });
    } else {
      // Handle error
      print('Failed to load booked slots data');
    }
  }

  Future<void> updateAlumniStatus(
      String alumniId,
      String date,
      String time,
      ) async {
    try {
      final response = await http.post(
        Uri.parse(link2),
        body: {
          'alumni_id': alumniId,
          'date': date,
          'time': time,
        },
      );

      if (response.statusCode == 200) {
        print('Alumni status updated successfully');
      } else {
        print(
            'Failed to update alumni status. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating alumni status: $error');
    }
  }

  final List<Color> aluminiColors = [
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.teal.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              // Show cancel confirmation dialog using GetX
              Get.defaultDialog(
                title: 'Cancel All Appointments?',
                content: Text('Are you sure you want to cancel all the appointments?'),
                confirm: ElevatedButton(
                  onPressed: () async {
                    // Loop through all booked slots and update alumni status
                    for (var index = 0; index < bookedSlots.length; index++) {
                      await updateAlumniStatus(
                        bookedSlots[index].alumniId,
                        bookedSlots[index].selectedDate,
                        bookedSlots[index].selectedTime,
                      );
                    }

                    // Clear the booked slots list
                    setState(() {
                      fetchData();
                    });
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff1B3FAB),
                  ),
                  child: Text('Yes'),
                ),
                cancel: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('No'),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: bookedSlots.length,
                    itemBuilder: (context, index) {
                      final Color aluminiColor = aluminiColors[index % aluminiColors.length];

                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        color: aluminiColor,
                        child: ListTile(
                          title: Text(
                            'Alumni Name: ${bookedSlots[index].alumniName}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Date: ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(bookedSlots[index].selectedDate!))}',
                              ),
                              Text(
                                'Selected Time: ${DateFormat('h:mm a').format(DateTime.parse("${bookedSlots[index].selectedDate} ${bookedSlots[index].selectedTime}"))}',
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'Cancel the Selected Appointment?',
                                content: Text(
                                  'Are you sure you want to cancel the selected appointment?',
                                ),
                                confirm: ElevatedButton(
                                  onPressed: () async {
                                    await updateAlumniStatus(
                                      bookedSlots[index].alumniId,
                                      bookedSlots[index].selectedDate,
                                      bookedSlots[index].selectedTime,
                                    );

                                    setState(() {
                                      fetchData();
                                    });
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff1B3FAB),
                                  ),
                                  child: Text('Yes'),
                                ),
                                cancel: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  child: Text('No'),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

