import 'package:DocSpot/colors/customColors.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('My Appointments',style: TextStyle(color: CustomColors.navText, fontSize: 20, fontWeight: FontWeight.w600),),
        ),

      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Color(0xFFf1eaff), Color.fromARGB(255, 201, 187, 231)],
        //   ),
        // ),
        child: Center(
          child: Text(
            'Your Appointments Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}