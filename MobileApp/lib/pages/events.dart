import 'package:flutter/material.dart';
import 'location.dart';
import 'package:intl/intl.dart';

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
  final String location;
  const EventPage({super.key, required this.location});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final Map<String, LatLng> locationMap = {
    "Fence Area A": LatLng(7.2906, 80.6337)
  };

  Event? selectedEvent;

  @override
  void initState() {
    super.initState();

    final loc = widget.location;
    final coords = locationMap[loc];

    if (coords != null) {
      selectedEvent = Event(
        name: loc,
        date: DateTime.now(),
        latitude: coords.latitude,
        longitude: coords.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alert Location',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        toolbarHeight: 70,
        backgroundColor: const Color(0xFF1E426B),
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      backgroundColor: const Color(0xFF1E426B),
      body: selectedEvent == null
          ? const Center(
              child: Text(
                "Location not found",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📍 Location of: ${selectedEvent!.name}",
                    style: TextStyle(
                      fontSize: width < 600 ? 20 : 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E5077),
                    ),
                  ),
                  const SizedBox(height: 12),
                  EventLocationMap(event: selectedEvent!),
                  const SizedBox(height: 24),
                  Text(
                    "🕒 Triggered at: ${DateFormat('yyyy-MM-dd hh:mm a').format(selectedEvent!.date)}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}

// Helper class for coordinates
class LatLng {
  final double latitude;
  final double longitude;
  LatLng(this.latitude, this.longitude);
}
