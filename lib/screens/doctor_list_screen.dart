import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api/endPoint.dart';

//////////////////////////////////////////////////////////////Doctor List///////////////////////////////////////////////////////////////////////

class DoctorListScreen extends StatefulWidget {
  final int hospitalId;
  final int departmentId;

  DoctorListScreen({required this.hospitalId, required this.departmentId});

  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  List<dynamic> doctors = [];

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    final response = await http.get(Uri.parse(
        '$apiUrl/api/hospitals/${widget.hospitalId}/departments/${widget.departmentId}/doctors/'));

    if (response.statusCode == 200) {
      doctors = jsonDecode(response.body);
      print(doctors);
      setState(() {});
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf1eaff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87, // Use the iPhone-style back arrow icon
          ),
          onPressed: () {
            // Handle back button press here
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Doctor List',
          style:
              TextStyle(color: Color(0xFF755ca7), fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (BuildContext context, int index) {
          final doctor = doctors[index];
          return ListTile(
            title: Text(doctor['doctor_name']),
          );
        },
      ),
    );
  }
}
