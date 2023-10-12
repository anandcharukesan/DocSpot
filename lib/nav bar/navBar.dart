import 'package:flutter/material.dart';

import '../colors/customColors.dart';
import '../screens/Appointments/appointmentsPage.dart';
import '../screens/Bookmark/bookmartPage.dart';
import '../screens/Settings/settingsPage.dart';
import '../screens/homeScreen/hospital_list_screen.dart';



class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();

  static void setIndex(int i) {}
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HospitalListScreen( isFirst: -1),
    AppointmentsPage(),
    BookmarkPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void setIndex(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(top: 8,),
              decoration: BoxDecoration(
                color: CustomColors.navbarbgColor,
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),

              ),
              child: BottomNavigationBar(
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined),
                    label: 'Home',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.timer),
                    label: 'Search',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark),
                    label: 'Profile',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'About',
                    backgroundColor: Colors.transparent,
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: CustomColors.secondaryColor,
                unselectedItemColor: CustomColors.textColor,
                onTap: _onItemTapped,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}




