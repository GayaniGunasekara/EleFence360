import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location.dart';

class Event {
  final String name;
  final DateTime date;
  final double latitude;
  final double longitude;

  Event({
    required this.name,
    required this.date,
    required this.latitude,
    required this.longitude,
  });
}

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Event> events = [
    Event(
      name: "🚧 Fence Issue Detected",
      date: DateTime.now().subtract(const Duration(hours: 1)),
      latitude: 6.9271,
      longitude: 79.8612,
    ),
    Event(
      name: "🐘 Elephant Detected Near Border",
      date: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      latitude: 7.2906,
      longitude: 80.6337,
    ),
  ];

  Event? selectedEvent;

  @override
  Widget build(BuildContext context) {
    events.sort((a, b) => b.date.compareTo(a.date));
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🐘 Elephant Fence Alerts'),
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: const Color(0xFF2E5077),
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Alerts",
              style: TextStyle(
                fontSize: width < 600 ? 20 : 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E5077),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedEvent = event;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(width: 5, color: const Color(0xFF4DA1A9)),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                color: Color(0xFF4E8BD4), size: 40),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "📅 ${event.date.toLocal()}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right,
                                color: Color(0xFF4DA1A9), size: 30),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedEvent != null) ...[
              const SizedBox(height: 14),
              Text(
                "📍 Location of: ${selectedEvent!.name}",
                style: TextStyle(
                  fontSize: width < 600 ? 18 : 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2E5077),
                ),
              ),
              const SizedBox(height: 12),
              EventLocationMap(event: selectedEvent!),
            ],
          ],
        ),
      ),
    );
  }
}
