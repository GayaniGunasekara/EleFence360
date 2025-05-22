import 'package:flutter/material.dart';

void main() {
  runApp(WildlifeDepartmentApp());
}

class WildlifeDepartmentApp extends StatelessWidget {
  const WildlifeDepartmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Details 3',
      debugShowCheckedModeBanner: false,
      home: WildlifeDepartmentScreen(),
    );
  }
}

class WildlifeDepartmentScreen extends StatelessWidget {
  const WildlifeDepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors based on the screenshot
    final Color backgroundColor = Color(0xFF6ED3C7); // Main background
    final Color cardColor = Color(0xFF53B6B0);      // Card color
    final Color headerColor = Colors.white;         // Header background

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Container(
                width: 340,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with back arrow and title
                      Row(
                        children: [
                          Icon(Icons.arrow_back, size: 26, color: Colors.black87),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: headerColor,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  "WILDLIFE DEPARTMENT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Serif',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      // Department name
                      InfoCard(
                        color: cardColor,
                        icon: Icons.account_balance,
                        text: "Department of Wildlife Conservation",
                      ),
                      SizedBox(height: 18),
                      // Address
                      InfoCard(
                        color: cardColor,
                        icon: Icons.location_on_outlined,
                        text: "811A, Jayanthipura,\nBattaramulla, Sri Lanka.",
                      ),
                      SizedBox(height: 18),
                      // Phone
                      InfoCard(
                        color: cardColor,
                        icon: Icons.phone,
                        text: "+94 11 2 888 585",
                      ),
                      SizedBox(height: 18),
                      // Email
                      InfoCard(
                        color: cardColor,
                        icon: Icons.email_outlined,
                        text: "dg@dwc.gov.lk",
                        underline: true,
                      ),
                      SizedBox(height: 18),
                      // Website
                      InfoCard(
                        color: cardColor,
                        icon: Icons.link,
                        text: "Wildlife Department",
                        underline: true,
                      ),
                      SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final bool underline;

  const InfoCard({super.key, 
    required this.color,
    required this.icon,
    required this.text,
    this.underline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black87, size: 22),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                decoration: underline ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
