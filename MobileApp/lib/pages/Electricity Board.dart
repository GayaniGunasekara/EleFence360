import 'package:flutter/material.dart';

class ElectricityBoardApp extends StatelessWidget {
  const ElectricityBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElectricityBoardScreen();
  }
}

class ElectricityBoardScreen extends StatelessWidget {
  const ElectricityBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Color(0xFF4E8BD4).withOpacity(0.5);    // Main background color
    final Color cardColor = Color(0xFFFFFFFF); // Card color

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Electricity Board Details',
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 18.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoCard(
                          cardColor: cardColor,
                          icon: Icons.apartment,
                          child: Text(
                            "Ceylon Electricity Board",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        InfoCard(
                          cardColor: cardColor,
                          icon: Icons.location_on_outlined,
                          child: Text(
                            "50 Sir Chittampalam A\nGardiner Mawatha\nColombo 00200, 00700",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        InfoCard(
                          cardColor: cardColor,
                          icon: Icons.phone,
                          child: Text(
                            "1987",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        InfoCard(
                          cardColor: cardColor,
                          icon: Icons.email_outlined,
                          child: Text(
                            "info(at)electricity.gov.lk",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        InfoCard(
                          cardColor: cardColor,
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
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final Color cardColor;
  final IconData icon;
  final Widget child;

  const InfoCard({
    super.key,
    required this.cardColor,
    required this.icon,
    required this.child,
  });

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
