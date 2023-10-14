import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:DocSpot/api/endPoint.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final String hospital;

  DoctorDetailsScreen({required this.doctor, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf1eaff),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(0xFFa48dd0),
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
        title: Text(
          'Doctor List',
          // style:
          //     TextStyle(color: Color(0xFF755ca7), fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Doctor Name and Specialization
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  doctor['doctor_name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2344), // Text color
                  ),
                ),
                Text(
                  doctor['specialization'],
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFA38CCF), // Text color
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Hospital Name
            Text(
              'Hospital: $hospital',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 135, 99, 207), // Text color
              ),
            ),
            SizedBox(height: 16),
            // Timings
            Text(
              'Timings: 9.00 - 2.00 lunch 4.00 - 8.00',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 135, 99, 207), // Text color
              ),
            ),
            SizedBox(height: 24),
            // Book Doctor Button
            ElevatedButton(
              onPressed: () async {
                   try {
  final response = await http.post(Uri.parse('$apiUrl/api/bookdoctor/${doctor["id"]}'));
  if (response.statusCode == 200) {
    print("Request was successful: ${response.body}");
  } else {
    print("Request failed with status code: ${response.statusCode} ${response.body}");
  }
} catch (e) {
  print("Error making the request: $e");
}

              },
              child: Text(
                'Book Doctor',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFa48dd0), // Button background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
