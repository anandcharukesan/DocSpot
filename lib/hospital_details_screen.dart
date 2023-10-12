import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'colors.dart'; // Import the colors file
import 'doctor_list_screen.dart'; // Import the DoctorListScreen

class HospitalDetailsScreen extends StatefulWidget {
  final int hospitalId;

  HospitalDetailsScreen({required this.hospitalId});

  @override
  _HospitalDetailsScreenState createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
  List<dynamic> departments = [];
  bool showDoctors = false;

  void toggleView() {
    setState(() {
      showDoctors = !showDoctors;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDepartments();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showDoctors ? 'Doctor List' : 'Hospital Details'),
        backgroundColor: appBarColor, // Set the app bar color
      ),
      body: Container(
        decoration: BoxDecoration(
          color: backgroundColor, // Set the background color
        ),
        child: showDoctors
            ? DoctorListScreen(
          hospitalId: widget.hospitalId,
          departmentId: 1, // Replace with the default department ID or handle it accordingly
        )
            : ListView.builder(
          itemCount: departments.length,
          itemBuilder: (BuildContext context, int index) {
            final department = departments[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  title: Text(department['department_name']),
                  subtitle: Text(department['description']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorListScreen(
                          hospitalId: widget.hospitalId,
                          departmentId: department['id'],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorListScreen(
                  hospitalId: widget.hospitalId,
                  departmentId: 1, // Replace with the default department ID or handle it accordingly
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: appBarColor, // Set the button background color
          ),
          child: Text(
            'Doctors',
            style: TextStyle(color: Colors.white), // Set the text color
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HospitalDetailsScreen(hospitalId: widget.hospitalId),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: appBarColor, // Set the button background color
          ),
          child: Text(
            'Departments',
            style: TextStyle(color: Colors.white), // Set the text color
          ),
        ),
      ],
    );
  }
}
