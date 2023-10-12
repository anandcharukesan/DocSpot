import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'hospital_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HospitalListScreen(),
    );
  }
}

class HospitalListScreen extends StatefulWidget {
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
    final response =
        await http.get(Uri.parse('http://192.168.29.206:8000/api/hospitals/'));

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
            colors: [Color(0xFFf1eaff), Color(0xFFe7dcff)],
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
                          color: Colors.grey, // Shadow color
                          offset: Offset(0,
                              2), // Offset of the shadow (horizontal, vertical)
                          blurRadius: 8, // Blur radius of the shadow
                          spreadRadius: 0, // Spread radius of the shadow
                        ),
                      ],
                      color: Color(
                          0xFFf8f4ff), // Background color of the search bar
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: TextField(
                      cursorColor: Colors.grey,
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Hospitals',
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
                      color: Color(0xFFa48dd0),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(17),
                          topLeft: Radius.circular(17),
                          bottomRight: Radius.circular(17))),
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
                        vertical: 3.0,
                        horizontal: 22.0), // Add vertical padding
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3), // Shadow color
                            offset: Offset(0, 2), // Offset of the shadow (horizontal, vertical)
                            blurRadius: 4, // Blur radius of the shadow
                            spreadRadius: 0, // Spread radius of the shadow
                          ),
                        ],
                        // Background color of the search bar
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      child: Card(
                        color: Color(0xFFf8f4ff),
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
                                style: TextStyle(color: Color(0xFFAB82FF)),
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
