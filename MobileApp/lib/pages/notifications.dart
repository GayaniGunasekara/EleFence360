import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'notification_details.dart';
import 'package:intl/intl.dart';

class NotificationItem {
  final String title;
  final String alertNumber;
  final String location;
  final String dateTime;
  int count;

  NotificationItem(
    this.title,
    this.alertNumber,
    this.location,
    this.dateTime, {
    this.count = 1,
  });
}

class AlertEntry {
  final NotificationItem item;
  final DateTime time;

  AlertEntry(this.item, this.time);
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('sensors');
  List<AlertEntry> activeAlerts = [];

  @override
  void initState() {
    super.initState();

    databaseRef.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      final now = DateTime.now();

      if (data != null) {
        if (data['vibration'] == true) {
          _handleAlert(
            'Elephant Detected',
            'A001',
            'Fence Area A',
            now,
          );
        }

        if (data['voltage'] == false) {
          _handleAlert(
            'Electric Fence Power Issue',
            'A001',
            'Fence Area A',
            now,
          );
        }

        if (data['tilt'] != null && (data['tilt'] as double) > 30.0) {
          _handleAlert(
            'Fence Damage Detected',
            'A001',
            'Fence Area A',
            now,
          );
        }

        _cleanOldAlerts();
      }
    });
  }

  void _handleAlert(String title, String alertNumber, String location, DateTime now) {
    final existing = activeAlerts.indexWhere(
      (entry) =>
          entry.item.title == title &&
          entry.item.location == location &&
          now.difference(entry.time) < const Duration(hours: 1),
    );

    if (existing >= 0) {
      setState(() {
        activeAlerts[existing].item.count++;
        activeAlerts[existing] = AlertEntry(activeAlerts[existing].item, now);
      });
    } else {
      final newItem = NotificationItem(
        title,
        alertNumber,
        location,
        DateFormat('yyyy-MM-dd hh:mm a').format(now),
      );

      activeAlerts.add(AlertEntry(newItem, now));
      _sortAlerts();
      setState(() {});
    }
  }

  void _cleanOldAlerts() {
    final now = DateTime.now();
    activeAlerts = activeAlerts
        .where((entry) => now.difference(entry.time) < const Duration(hours: 1))
        .toList();
    _sortAlerts();
    setState(() {});
  }

  void _sortAlerts() {
    activeAlerts.sort((a, b) => b.time.compareTo(a.time));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E426B),
      body: Column(
        children: [
          ClipPath(
            clipper: TopWaveClipper(),
            child: Container(
              height: 250,
              color: const Color(0xFF5199EE),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: const Text(
                'Stay\nInformed...',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: activeAlerts.isEmpty
                ? const Center(
                    child: Text(
                      'No Alerts 🚫',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: activeAlerts.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final item = activeAlerts[index].item;
                      return Card(
                        color: const Color(0xFF4E8BD4).withOpacity(0.5),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  const CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.warning, color: Colors.red),
                                  ),
                                  if (item.count > 1)
                                    Positioned(
                                      right: 0,
                                      top: -4,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '${item.count}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => NotificationDetailPage(
                                        alertNumber: item.alertNumber,
                                        type: item.title,
                                        location: item.location,
                                        dateTime: item.dateTime,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('View Info'),
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
