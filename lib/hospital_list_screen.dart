import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'hospital_details_screen.dart';

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
    final response = await http.get(Uri.parse('https://691f-117-250-228-98.ngrok-free.app/api/hospitals/'));
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
