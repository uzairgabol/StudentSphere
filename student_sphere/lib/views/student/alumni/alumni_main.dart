import 'package:student_sphere/consts/consts.dart';
import 'alumni_booking.dart';
import 'alumni_details.dart';
import 'package:http/http.dart' as http;

var link = localhostip + "/api/alumni/";
var link1 = link + "alumnidata.php";
var link2 = link + "alumnidates.php";

class Timing {
  final String date;
  final String time;

  Timing({
    required this.date,
    required this.time,
  });
}

class AluminiData {
  final int alumni_id;
  final String name;
  final String degree;
  final int graduationYear;
  final String description;
  //final String imagePath;
  List<DateData> dates;

  AluminiData({
    required this.alumni_id,
    required this.name,
    required this.degree,
    required this.graduationYear,
    required this.description,
    //required this.imagePath,
    required this.dates,
  });
}

class DateData {
  final String date;
  final List<Timing> timeSlots;

  DateData({
    required this.date,
    required this.timeSlots,
  });
}

class Alumni extends StatefulWidget {
  final String stuId;
  const Alumni({super.key, required this.stuId});

  @override
  _AlumniState createState() => _AlumniState();
}

class _AlumniState extends State<Alumni> {
  List<AluminiData> aluminiList = [];


  @override
  void initState() {
    super.initState();
    fetchData();
  }


  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(link1));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        aluminiList = data.map((item) => AluminiData(
          alumni_id: int.parse(item['alumni_id'].toString()),
          name: item['alumni_name'],
          degree: item['degree'],
          graduationYear: int.parse(item['graduation_year'].toString()),
          description: item['description'],
          dates: [],
        )).toList();

        // Fetch dates data for each alumni
        for (AluminiData aluminiData in aluminiList) {
          fetchDatesData(aluminiData.alumni_id);
        }
      });
    } else {
      // Handle error
      print('Failed to load data');
    }
  }

  Future<void> fetchDatesData(int alumniId) async {

    // Create a map with the required parameters
    final Map<String, dynamic> requestData = {
      'alumni_id': alumniId.toString(),
    };

    final response = await http.post(
      Uri.parse(link2),
      body: requestData,
    );

    if (response.statusCode == 200) {
      final List<dynamic> datesData = jsonDecode(response.body);

      final AluminiData aluminiData = aluminiList.firstWhere(
            (data) => data.alumni_id == alumniId,
      );
      aluminiData.dates = datesData.map((item) => DateData(
        date: item['date'],
        timeSlots: [Timing(date: item['date'], time: item['time'])],
      )).toList();

      // Set the state to trigger a rebuild with the updated data
      setState(() {});
    } else {
      // Handle error
      print('Failed to load dates data for alumni_id: $alumniId');
    }
  }

  final List<Color> cardColors = [
    Color(0xFF3D5AFE), // Deep Blue
    Color(0xFF00C853), // Green
    Color(0xFFFF9100), // Orange
    Color(0xFF00BFA5), // Teal
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              Get.to(() => BookedSlotsPage(stuId: widget.stuId));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: aluminiList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => AlumniInfo(aluminiData: aluminiList[index], stuId: widget.stuId,));
                    },
                    child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 120, // Set the desired height
                        color: cardColors[index % cardColors.length],
                        child: ListTile(
                          title: Text(
                            aluminiList[index].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                aluminiList[index].degree,
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                'Batch ${aluminiList[index].graduationYear}',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}