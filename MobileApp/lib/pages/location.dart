import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'events.dart';

class EventLocationMap extends StatelessWidget {
  final Event event;

  const EventLocationMap({super.key, required this.event, required String location});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF79D7BE), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E5077).withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(event.latitude, event.longitude),
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("event_location"),
              position: LatLng(event.latitude, event.longitude),
              infoWindow: InfoWindow(title: event.name),
            ),
          },
          onMapCreated: (controller) {},
        ),
      ),
    );
  }
}
