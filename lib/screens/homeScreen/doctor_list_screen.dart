import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/endPoint.dart';

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
    );
  }
}
