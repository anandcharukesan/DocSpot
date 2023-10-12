import 'package:DocSpot/screens/homeScreen/hospital_list_screen.dart';
import 'package:flutter/material.dart';

import 'nav bar/navBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarPage(),
    );
  }
}