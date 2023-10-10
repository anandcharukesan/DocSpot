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
    final response = await http.get(Uri.parse('http://192.168.137.1:8000/api/hospitals/'));
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFf0e9ff), Color(0xFFe7dcff)],
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 8, top: 120, right: 8, bottom: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the search bar
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Hospitals',
                      border: InputBorder.none,

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
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15, right: 30, left: 30),
                    child: Text(
                      'Hospitals',
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
                    padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0), // Add vertical padding
                    child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        height: 90.0,
                        child: ListTile(
                          title: Text(hospital['hospital_name']),
                          subtitle: Text(hospital['district']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HospitalDetailsScreen(hospitalId: hospital['id']),
                              ),
                            );
                          },
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
