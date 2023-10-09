import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    final response = await http.get(Uri.parse('https://691f-117-250-228-98.ngrok-free.app/api/hospitals/${widget.hospitalId}/departments/${widget.departmentId}/doctors/'));
    if (response.statusCode == 200) {
      doctors = jsonDecode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor List'),
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
