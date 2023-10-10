import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'doctor_list_screen.dart';

class HospitalDetailsScreen extends StatefulWidget {
  final int hospitalId;

  HospitalDetailsScreen({required this.hospitalId});

  @override
  _HospitalDetailsScreenState createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
  List<dynamic> departments = [];
  List<dynamic> doctors = [];

  @override
  void initState() {
    super.initState();
    fetchDepartments();
    fetchDoctors();
  }

  Future<void> fetchDepartments() async {
    final response = await http.get(Uri.parse('http://192.168.137.1:8000/api/hospitals/${widget.hospitalId}/departments/'));
    if (response.statusCode == 200) {
      departments = jsonDecode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to load departments');
    }
  }

  Future<void> fetchDoctors() async {
    final response = await http.get(Uri.parse('http://192.168.137.1:8000/api/hospitals/1/departments/2/doctors/'));
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
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Color(0xFFa48dd0),
          title: Text('Hospital Details'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Departments'),
              Tab(text: 'Doctors'),
            ],
            indicatorColor: Color(0xFFf8f4ff), // Set the color of the bottom indicator line

          ),
        ),
        body: TabBarView(
          children: [
            // Departments Tab
            ListView.builder(
              itemCount: departments.length,
              itemBuilder: (BuildContext context, int index) {
                final department = departments[index];
                return ListTile(
                  title: Text(department['department_name']),
                  subtitle: Text(department['description']),
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
                );
              },
            ),
            // Doctors Tab
            ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (BuildContext context, int index) {
                final doctor = doctors[index];
                return ListTile(
                  title: Text(doctor['doctor_name']),
                  subtitle: Text(doctor['specialization']),
                  // Add onTap functionality for doctors if needed
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
