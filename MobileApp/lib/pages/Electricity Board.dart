import 'package:flutter/material.dart';

void main() {
  runApp(ElectricityBoardApp());
}

class ElectricityBoardApp extends StatelessWidget {
  const ElectricityBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Details 7',
      debugShowCheckedModeBanner: false,
      home: ElectricityBoardScreen(),
    );
  }
}

class ElectricityBoardScreen extends StatelessWidget {
  const ElectricityBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Color(0xFF6ED3C7); // Main background
    final Color cardColor = Color(0xFF5CB8B2);      // Card color
    final Color headerColor = Colors.white;         // Header background

    return Scaffold(
      backgroundColor: Color(0xFF232323),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: headerColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              "ELECTRICITY BOARD",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Serif',
                                color: Colors.black,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      InfoCard(
                        color: cardColor,
                        icon: Icons.apartment,
                        child: Text(
                          "Ceylon Electricity Board",
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                      SizedBox(height: 18),
                      InfoCard(
                        color: cardColor,
                        icon: Icons.location_on_outlined,
                        child: Text(
                          "50 Sir Chittampalam A\nGardiner Mawatha\nColombo 00200, 00700",
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                      SizedBox(height: 18),
                      InfoCard(
                        color: cardColor,
                        icon: Icons.phone,
                        child: Text(
                          "1987",
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                      SizedBox(height: 18),
                      InfoCard(
                        color: cardColor,
                        icon: Icons.email_outlined,
                        child: SizedBox.shrink(), // No email in screenshot
                      ),
                      SizedBox(height: 18),
                      InfoCard(
                        color: cardColor,
                        icon: Icons.link,
                        child: Text(
                          "Electricity Board",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            decoration: TextDecoration.underline,
                          ),
                        ),
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
  final Widget child;

  const InfoCard({super.key, required this.color, required this.icon, required this.child});

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
          Expanded(child: child),
        ],
      ),
    );
  }
}
