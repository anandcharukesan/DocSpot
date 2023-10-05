import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    final response = await http.get(Uri.parse('https://c709-117-250-228-98.ngrok-free.app/api/hospitals/'));
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
      appBar: AppBar(
        title: Text('Hospital List'),
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (BuildContext context, int index) {
          final hospital = hospitals[index];
          return ListTile(
            title: Text(hospital['hospital_name']),
            subtitle: Text(hospital['district']),
            onTap: () {
              // Navigate to the HospitalDetailsScreen with hospital ID
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HospitalDetailsScreen(hospitalId: hospital['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

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
    final response = await http.get(Uri.parse('https://c709-117-250-228-98.ngrok-free.app/api/hospitals/${widget.hospitalId}/departments/'));
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
          );
        },
      ),
    );
  }
}
