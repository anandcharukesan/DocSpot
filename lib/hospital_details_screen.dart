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

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {
    final response = await http.get(Uri.parse('https://691f-117-250-228-98.ngrok-free.app/api/hospitals/${widget.hospitalId}/departments/'));
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
        title: Text('Hospital Details'),
      ),
      body: ListView.builder(
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
                    departmentId: department['id'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
