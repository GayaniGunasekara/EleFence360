import 'package:flutter/material.dart';

void main() {
  runApp(NotificationApp());
}

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Interface',
      debugShowCheckedModeBanner: false,
      home: NotificationScreen(),
    );
  }
}

class NotificationItem {
  final String title;
  final int count;

  NotificationItem(this.title, this.count);
}

class NotificationScreen extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem('Elephants near the fence!', 2),
    NotificationItem('Electricity issues in the fence.', 0),
    NotificationItem('Fence Damages', 1),
    NotificationItem('Other Emergencies', 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipPath(
            clipper: TopWaveClipper(),
            child: Container(
              height: 200,
              color: Colors.teal[200],
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: const Text(
                'Stay\nInformed...',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Card(
                  color: Colors.indigo[900],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.cyanAccent,
                            ),
                            if (item.count > 0)
                              Positioned(
                                right: -5,
                                top: -5,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${item.count}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => NotificationDetailPage(
                                      alertNumber: '0001',
                                      type: item.title,
                                      location: 'Location X',
                                      dateTime: '2025-05-15 10:30 AM',
                                    ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                          ),
                          child: Text('View Information'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class NotificationDetailPage extends StatelessWidget {
  final String alertNumber;
  final String type;
  final String location;
  final String dateTime;

  const NotificationDetailPage({
    super.key,
    required this.alertNumber,
    required this.type,
    required this.location,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification info', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.indigo[900],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.teal.shade200, width: 8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfo('Alert No :', alertNumber),
              buildInfo('Notification Type :', type),
              buildInfoLink('Location :', 'View', () {
                // Replace with your map logic
                print('Open map for $location');
              }),
              buildInfo('Detected Time/ Date :', dateTime),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(value, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget buildInfoLink(String label, String linkText, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  linkText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
