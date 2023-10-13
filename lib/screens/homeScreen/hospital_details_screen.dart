import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../api/endPoint.dart';
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
    final response = await http.get(
        Uri.parse('$apiUrl/api/hospitals/${widget.hospitalId}/departments/'));

    if (response.statusCode == 200) {
      departments = jsonDecode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to load departments');
    }
  }

  Future<void> fetchDoctors() async {
    final response = await http
        .get(Uri.parse('$apiUrl/api/hospitals/${widget.hospitalId}/doctors/'));
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
        backgroundColor: Color.fromARGB(255, 224, 214, 249),
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
            indicatorColor:
                Color(0xFFf8f4ff), // Set the color of the bottom indicator line
          ),
        ),
        body: Column(
          children: [
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
                        margin: index == 0
                            ? EdgeInsets.only(
                                top: 20, bottom: 5, left: 26, right: 26)
                            : EdgeInsets.symmetric(vertical: 5, horizontal: 26),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Color.fromARGB(255, 242, 236, 253),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0, 2),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: ListTile(
                            title: Text(
                              department['department_name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF2E2344),
                              ),
                            ),
                            subtitle: Text(
                              department['description'],
                              style: TextStyle(
                                  color: Color(0xFFA38CCF), fontSize: 12),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorListScreen(
                                    hospitalId: widget.hospitalId,
                                    departmentId: department['department_id'],
                                    hospital_name: widget.hospitalName,
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
                        margin: index == 0
                            ? EdgeInsets.only(
                                top: 20, bottom: 5, left: 26, right: 26)
                            : EdgeInsets.symmetric(vertical: 5, horizontal: 26),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Color.fromARGB(255, 242, 236, 253),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0, 2),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              doctor['doctor_name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF2E2344),
                              ),
                            ),
                            subtitle: Text(
                              doctor['specialization'],
                              style: TextStyle(color: Color(0xFFA38CCF)),
                            ),
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
