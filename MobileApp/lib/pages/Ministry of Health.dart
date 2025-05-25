import 'package:flutter/material.dart';


class HospitalDetailsApp extends StatelessWidget {
  const HospitalDetailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HospitalDetailsScreen();
    
  }
}

class HospitalDetailsScreen extends StatelessWidget {
  const HospitalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Color(0xFF4E8BD4).withOpacity(0.5); 
    final Color cardColor = Color(0xFFFFFFFF);      // Info card color
// Header background

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
        title: Text(
          'Hospital Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        toolbarHeight: 70,
        backgroundColor: Color(0xFF1E426B),        
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1E426B),
      body: SafeArea(
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
                      // Header

                      InfoCard(
                        cardColor: cardColor,
                        icon: Icons.apartment,
                        child: Text(
                          "Ministry of Health",
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                      SizedBox(height: 18),
                      InfoCard(
                        cardColor: cardColor,
                        icon: Icons.location_on_outlined,
                        child: Text(
                          "Suwasiripaya, No. 385,\nRev. Baddegama Wimalawansa\nThero Mawatha,\nColombo 10, Sri Lanka.",
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                      SizedBox(height: 18),
                      InfoCard(
                        cardColor: cardColor,
                        icon: Icons.phone,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("(94) 112 694033", style: TextStyle(fontSize: 15, color: Colors.black87)),
                            Text("(94) 112 675011", style: TextStyle(fontSize: 15, color: Colors.black87)),
                            Text("(94) 112 675449", style: TextStyle(fontSize: 15, color: Colors.black87)),
                            Text("(94) 112 693493", style: TextStyle(fontSize: 15, color: Colors.black87)),
                          ],
                        ),
                      ),
                      SizedBox(height: 18),
                      InfoCard(
                        cardColor: cardColor,
                        icon: Icons.email_outlined,
                        child: Text(
                          "info(at)health.gov.lk",
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                      SizedBox(height: 18),
                      InfoCard(
                        cardColor: cardColor,
                        icon: Icons.link,
                        child: Text(
                          "Ministry of Health.",
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
  final Color cardColor;
  final IconData icon;
  final Widget child;

  const InfoCard({super.key, required this.cardColor, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      margin: EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: cardColor,
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
