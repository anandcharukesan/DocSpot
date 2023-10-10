import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {

    final response = await http.get(Uri.parse('http://192.168.137.194:8000/api/hospitals/${widget.hospitalId}/departments/'));

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
      backgroundColor: Colors.purple, // Set background color to light purple
      appBar: AppBar(
        backgroundColor: Colors.purple, // Match the background color
        elevation: 0, // Remove the elevation shadow
        title: Text(widget.hospitalName), // Show hospital name in the title bar
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Departments',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: departments.length,
              itemBuilder: (BuildContext context, int index) {
                final department = departments[index];
                return ListTile(
                  title: Text(
                    department['department_name'],
                    style: TextStyle(color: Colors.pink), // Set text color to dark violet
                  ),
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
          ),
        ],
      ),
    );
  }
}
