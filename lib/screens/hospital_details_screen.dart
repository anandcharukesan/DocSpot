import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/endPoint.dart';
import 'doctor_list_screen.dart';

class HospitalDetailsScreen extends StatefulWidget {
  final int hospitalId;
  final String hospitalName;

  HospitalDetailsScreen({
    required this.hospitalId,
    required this.hospitalName,
  });

  @override
  _HospitalDetailsScreenState createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
  List<dynamic> departments = [];
  List<dynamic> doctors = [];
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchDepartments();
    fetchDoctors();
  }

  Future<void> fetchDepartments() async {
    final response = await http.get(Uri.parse('$apiUrl/api/hospitals/${widget.hospitalId}/departments/'));

    if (response.statusCode == 200) {
      departments = jsonDecode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to load departments');
    }
  }

  Future<void> fetchDoctors() async {
    final response = await http.get(Uri.parse('$apiUrl/api/hospitals/${widget.hospitalId}/doctors/'));
    if (response.statusCode == 200) {
      doctors = jsonDecode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs, in this case, "Departments" and "Doctors"
      child: Scaffold(
        backgroundColor: Color(0xFFede5ff),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Color(0xFFa48dd0),
          title: Text("${widget.hospitalName}"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              // Use the iPhone-style back arrow icon
            ),
            onPressed: () {
              // Handle back button press here
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Departments'),
              Tab(text: 'Doctors'),
            ],
            indicatorColor: Color(0xFFf8f4ff), // Set the color of the bottom indicator line
          ),
        ),
        body: Column(
          children: [

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 22.0),
            //   child: Container(
            //
            //     margin: EdgeInsets.only(top: 20, bottom: 5),
            //     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey, // Shadow color
            //           offset: Offset(0,
            //               2), // Offset of the shadow (horizontal, vertical)
            //           blurRadius: 8, // Blur radius of the shadow
            //           spreadRadius: 0, // Spread radius of the shadow
            //         ),
            //       ],
            //       color: Color(0xFFf8f4ff), // Background color of the search bar
            //       borderRadius: BorderRadius.circular(17.0),
            //     ),
            //     child: TextField(
            //       cursorColor: Colors.grey,
            //       controller: searchController,
            //       decoration: InputDecoration(
            //         hintText: 'Search Doctors...',
            //         border: InputBorder.none,
            //       ),
            //     ),
            //   ),
            // ),

            // TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  // Departments Tab
                  ListView.builder(
                    itemCount: departments.length,
                    itemBuilder: (BuildContext context, int index) {
                      final department = departments[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Color(0xFFf8f4ff),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25), // Shadow color
                              offset: Offset(0, 2), // Offset of the shadow (horizontal, vertical)
                              blurRadius: 8, // Blur radius of the shadow
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 22),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(department['department_name'], style: TextStyle(fontWeight: FontWeight.w400,color: Color(0xFF2E2344)),),
                            subtitle: Text(department['description'], style: TextStyle(color: Color(0xFFA38CCF)),),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorListScreen(
                                    hospitalId: widget.hospitalId,
                                    departmentId: department['department_id'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  // Doctors Tab
                  ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (BuildContext context, int index) {
                      final doctor = doctors[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Color(0xFFf8f4ff),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25), // Shadow color
                              offset: Offset(0, 2), // Offset of the shadow (horizontal, vertical)
                              blurRadius: 8, // Blur radius of the shadow
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 22),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(doctor['doctor_name'],style: TextStyle(fontWeight: FontWeight.w400,color: Color(0xFF2E2344)),),
                            subtitle: Text(doctor['specialization'], style: TextStyle(color: Color(0xFFA38CCF)),),
                            // Add onTap functionality for doctors if needed
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

