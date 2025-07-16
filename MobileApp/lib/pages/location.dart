import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'events.dart';

class EventLocationMap extends StatelessWidget {
  final Event event;

  const EventLocationMap({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF1E426B), width: 1.3),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E426B).withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 4,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              gmap.GoogleMap(
                initialCameraPosition: gmap.CameraPosition(
                  target: gmap.LatLng(event.latitude, event.longitude),
                  zoom: 14,
                ),
                markers: {
                  gmap.Marker(
                    markerId: const gmap.MarkerId("event_location"),
                    position: gmap.LatLng(event.latitude, event.longitude),
                    infoWindow: gmap.InfoWindow(title: event.name),
                  ),
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                onMapCreated: (controller) {},
              ),
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF1E426B)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E426B),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
