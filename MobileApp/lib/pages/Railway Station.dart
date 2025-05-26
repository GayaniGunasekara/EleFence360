import 'package:flutter/material.dart';

class RailwayStationApp extends StatelessWidget {
  const RailwayStationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  RailwayStationScreen();
  }
}

class RailwayStationScreen extends StatelessWidget {
  const RailwayStationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Color(0xFF4E8BD4).withOpacity(0.5);    // Main background color
    final Color cardColor = Color(0xFFFFFFFF);      // Info card color

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Railway Station Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        toolbarHeight: 70,
        backgroundColor: Color(0xFF1E426B),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1E426B),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoCard(
                          color: cardColor,
                          icon: Icons.apartment,
                          child: Text(
                            "Srilanka Railways",
                            style: TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                        ),
                        SizedBox(height: 18),
                        // Address
                        InfoCard(
                          color: cardColor,
                          icon: Icons.location_on_outlined,
                          child: Text(
                            "Colombo",
                            style: TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                        ),
                        SizedBox(height: 18),
                        // Phone
                        InfoCard(
                          color: cardColor,
                          icon: Icons.phone,
                          child: Text(
                            "+94 11 4 600 111",
                            style: TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                        ),
                        SizedBox(height: 18),
                        // Email
                        InfoCard(
                          color: cardColor,
                          icon: Icons.email_outlined,
                          child: Text(
                            "gmr@railway.gov.lk",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        // Website Link
                        InfoCard(
                          color: cardColor,
                          icon: Icons.link,
                          child: Text(
                            "Srilanka Railways Station.",
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black87, size: 22),
          SizedBox(width: 14),
          Expanded(child: child),
        ],
      ),
    );
  }
}
