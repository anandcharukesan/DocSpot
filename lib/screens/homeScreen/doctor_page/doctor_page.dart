import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final String hospital;

  DoctorDetailsScreen({required this.doctor, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Details'),
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
                color: Color(0xFF2E2344), // Text color
              ),
            ),
            SizedBox(height: 16),
            // Timings
            Text(
              'Timings: 9.00 - 4.00',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF2E2344), // Text color
              ),
            ),
            SizedBox(height: 24),
            // Book Doctor Button
            ElevatedButton(
              onPressed: () {
                // Implement booking functionality here
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
