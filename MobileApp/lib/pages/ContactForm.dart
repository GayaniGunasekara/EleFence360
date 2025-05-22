import 'package:contactform/pages/Electricity%20Board.dart';
import 'package:contactform/pages/Police%20Station.dart';
import 'package:contactform/pages/Railway%20Station.dart';
import 'package:contactform/pages/Wildlife%20Department.dart';
import 'package:flutter/material.dart';
import 'Ministry of Health.dart';

class ContactFormScreen extends StatelessWidget {
  final List<String> contactOptions = [
    'HOSPITAL',
    'ELECTRICITY BORD',
    'WILDLIFE DEPARTMENT',
    'POLICE STATIONS',
    'RAILWAY STATIONS',
  ];

   ContactFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232323),
      body: Center(
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'CONTACT DETAILS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Serif',
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              // Main body
              Container(
                color: Color(0xFF6ED3C7),
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                child: Column(
                  children: contactOptions
                      .map(
                        (option) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4EB1A7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
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
                                  case 'ELECTRICITY BORD':
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
                                    page = Scaffold(body: Center(child: Text('Page not found')));
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => page),
                                );
                              },

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    option,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  Icon(Icons.chevron_right, color: Colors.black54),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
