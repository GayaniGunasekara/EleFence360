import 'package:flutter/material.dart';

class WildlifeDepartmentApp extends StatelessWidget {
  const WildlifeDepartmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WildlifeDepartmentScreen();
  }
}

class WildlifeDepartmentScreen extends StatelessWidget {
  const WildlifeDepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors based on the screenshot
    final Color backgroundColor = Color(
      0xFF4E8BD4,
    ).withOpacity(0.5); // Main background
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
                          icon: Icons.account_balance,
                          child: Text(
                            "Department of Wildlife Conservation",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        // Address
                        InfoCard(
                          cardColor: cardColor,
                          icon: Icons.location_on_outlined,
                          child: Text(
                            "No. 811, 2nd Floor, Rajagiriya Road, Kotte, Sri Lanka",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        // Phone
                        InfoCard(
                          cardColor: cardColor,
                          icon: Icons.phone,
                          child: Text(
                            "+94 11 288 8000",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        // Email
                        InfoCard(
                          cardColor: cardColor,
                          icon: Icons.email_outlined,
                          child: Text(
                            "dg@dwc.gov.lk",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        // Website
                        InfoCard(
                          cardColor: cardColor,
                          icon: Icons.link,
                          child: Text(
                            "Wildlife Department",
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
