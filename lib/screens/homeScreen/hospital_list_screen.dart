import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/endPoint.dart';
import '../../colors/customColors.dart';
import 'hospital_details_screen.dart';

class HospitalListScreen extends StatefulWidget {
  final int isFirst;

  HospitalListScreen({required this.isFirst});

  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  List<dynamic> hospitals = [];
  final String defaultImageBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wAAAAMAAQAC8UAAAAAAASUVORK5CYII=';

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    final response = await http.get(Uri.parse('$apiUrl/api/hospitals/'));

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
      backgroundColor: CustomColors.secondaryColor,
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(child: buildProfileSection()),
            SliverToBoxAdapter(child: buildSearchBar()),
            SliverToBoxAdapter(child: buildTopHospitalsTitle()),
            buildHospitalList(),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 90, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 15),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: CustomColors.iconBg,
              ),
              child: Image.asset(
                "assets/profile.png",
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
              SizedBox(height: 3),
              Text(
                'Dhiyanesh',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0),
      child: Container(
        margin: EdgeInsets.only(top: 40, bottom: 25),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 1),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
          color: Color.fromARGB(255, 242, 236, 253),
          borderRadius: BorderRadius.circular(17.0),
        ),
        child: TextField(
          cursorColor: Colors.grey,
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search Hospitals...',
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildTopHospitalsTitle() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          gradient: LinearGradient(
            colors: [
              Color(0xFFa48dd0),
              Color.fromARGB(255, 158, 135, 200),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 14,
            bottom: 14,
            right: 30,
            left: 30,
          ),
          child: Text(
            'Top Hospitals',
            style: TextStyle(
              color: Color(0xFFede4ff),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHospitalList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          final hospital = hospitals[index];

          List<int> imageBytes;

          try {
            print(hospital['image_data']);
            imageBytes = base64Decode(hospital['image_data']);
          } catch (e) {
            // Error decoding image, use a placeholder image or display an error image
            // You can specify a placeholder image or error image asset path
            // Make sure to include the appropriate image asset in your project
            imageBytes = base64Decode(defaultImageBase64); // Replace with your image data or asset
          }
          print(imageBytes);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(96, 80, 80, 80).withOpacity(0.1),
                    offset: Offset(0, 1),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
                borderRadius: BorderRadius.circular(17.0),
              ),
              child: Card(
                elevation: 0,
                color: Color.fromARGB(255, 242, 236, 253),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                ),
                child: Container(
                  height: 90.0,
                  child: Center(
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.memory(

                          Uint8List.fromList(imageBytes),
                          width: 45, // Set the width and height if needed
                          height: 45,
                        ),
                      ),
                      title: Text(hospital['hospital_name']),
                      subtitle: Text(
                        hospital['district'],
                        style: TextStyle(color: Color(0xFFA38CCF)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HospitalDetailsScreen(
                              hospitalId: hospital['id'],
                              hospitalName: hospital['hospital_name'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        childCount: hospitals.length,
      ),
    );
  }


}
