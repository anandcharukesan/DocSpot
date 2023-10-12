import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/endPoint.dart';
import 'hospital_details_screen.dart';


class HospitalListScreen extends StatefulWidget {

  final int isFirst; // Add this line

  HospitalListScreen({required this.isFirst});
  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  List<dynamic> hospitals = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    final response = await http.get(Uri.parse('$apiUrl/api/hospitals/'));

    if (response.statusCode == 200) {
      hospitals = jsonDecode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to load hospitals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFf1eaff), Color.fromARGB(255, 201, 187, 231)],
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 120, bottom: 25),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          offset: Offset(0,
                              1), // Offset of the shadow (horizontal, vertical)
                          blurRadius: 8, // Blur radius of the shadow
                          spreadRadius: 0, // Spread radius of the shadow
                        ),
                      ],
                      color: Color.fromARGB(255, 242, 236, 253),
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: TextField(
                      cursorColor: Colors.grey,
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Hospitals...',
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.8)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFa48dd0),
                        Color.fromARGB(255, 158, 135, 200),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 14, bottom: 14, right: 30, left: 30),
                    child: Text(
                      'Top Hospitals',
                      style: TextStyle(
                        color: Color(0xFFede4ff),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final hospital = hospitals[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 22.0), // Add vertical padding
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(96, 80, 80, 80)
                                .withOpacity(0.1), // Shadow color
                            offset: Offset(0,
                                1), // Offset of the shadow (horizontal, vertical)
                            blurRadius: 4, // Blur radius of the shadow
                            spreadRadius: 0, // Spread radius of the shadow
                          ),
                        ],
                        // Background color of the search bar
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      child: Card(
                        elevation: 0,
                        color: Color.fromARGB(255, 242, 236, 253),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.0),
                        ),
                        child: Container(
                          height: 90.0,
                          child: Center(
                            child: ListTile(
                              title: Text(hospital['hospital_name']),
                              subtitle: Text(
                                hospital['district'],
                                style: TextStyle(color: Color(0xFFA38CCF)),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HospitalDetailsScreen(
                                      hospitalId: hospital['id'],
                                      hospitalName: hospital['hospital_name'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: hospitals.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
