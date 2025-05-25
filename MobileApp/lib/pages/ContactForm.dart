import 'package:capstoneproject_mobileapp/pages/Electricity%20Board.dart';
import 'package:capstoneproject_mobileapp/pages/Police%20Station.dart';
import 'package:capstoneproject_mobileapp/pages/Railway%20Station.dart';
import 'package:capstoneproject_mobileapp/pages/Wildlife%20Department.dart';
import 'package:flutter/material.dart';
import 'Ministry of Health.dart';

class ContactFormScreen extends StatelessWidget {
  final List<String> contactOptions = [
    'HOSPITAL',
    'ELECTRICITY BOARD',
    'WILDLIFE DEPARTMENT',
    'POLICE STATIONS',
    'RAILWAY STATIONS',
  ];

  ContactFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        toolbarHeight: 70,
        backgroundColor: Color(0xFF1E426B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1E426B),
      body: SafeArea(
        top: false,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 60),
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              color: Color(0xFF4E8BD4).withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: contactOptions.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Widget page;
                        switch (option) {
                          case 'HOSPITAL':
                            page = HospitalDetailsApp();
                            break;
                          case 'ELECTRICITY BOARD':
                            page = ElectricityBoardApp();
                            break;
                          case 'WILDLIFE DEPARTMENT':
                            page = WildlifeDepartmentApp();
                            break;
                          case 'POLICE STATIONS':
                            page = PoliceStationApp();
                            break;
                          case 'RAILWAY STATIONS':
                            page = RailwayStationApp();
                            break;
                          default:
                            page = Scaffold(
                              body: Center(child: Text('Page not found')),
                            );
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => page),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0), // Add left padding here
                            child: Text(
                              option,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0), // Add right padding here
                            child: Icon(Icons.chevron_right, color: const Color(0x88000000)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}


