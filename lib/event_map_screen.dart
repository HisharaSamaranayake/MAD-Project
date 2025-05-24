import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class EventMapScreen extends StatefulWidget {
  final Map<String, String> event;

  const EventMapScreen({super.key, required this.event});

  @override
  State<EventMapScreen> createState() => _EventMapScreenState();
}

class _EventMapScreenState extends State<EventMapScreen> {
  late final LatLng eventLocation;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    eventLocation = LatLng(
      double.parse(widget.event['lat']!),
      double.parse(widget.event['lng']!),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.event['event']} Location'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: eventLocation,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId(widget.event['event']!),
            position: eventLocation,
            infoWindow: InfoWindow(title: widget.event['event']),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // You can add logic here for navigation or external map app opening if needed.
          // For example, launching Google Maps directions to this location.
        },
        label: Text('Navigate'),
        icon: Icon(Icons.navigation),
      ),
    );
  }
}
