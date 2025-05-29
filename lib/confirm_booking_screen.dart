import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'route_screen.dart'; // Import your RouteScreen here

class ConfirmBookingScreen extends StatefulWidget {
  final String pickup;
  final String destination;
  final String vehicleType;

  const ConfirmBookingScreen({
    super.key,
    required this.pickup,
    required this.destination,
    required this.vehicleType,
  });

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  late GoogleMapController mapController;

  final LatLng pickupLatLng = const LatLng(6.9271, 79.8612); // Example: Colombo
  final LatLng destinationLatLng = const LatLng(7.2906, 80.6337); // Example: Kandy

  double distanceKm = 0.0;
  double price = 0.0;

  @override
  void initState() {
    super.initState();
    distanceKm = calculateDistance(pickupLatLng, destinationLatLng);
    price = calculateFare(distanceKm, widget.vehicleType);
  }

  double calculateDistance(LatLng start, LatLng end) {
    const earthRadius = 6371; // in km
    final dLat = _deg2rad(end.latitude - start.latitude);
    final dLng = _deg2rad(end.longitude - start.longitude);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(start.latitude)) * cos(_deg2rad(end.latitude)) *
            sin(dLng / 2) * sin(dLng / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _deg2rad(double deg) => deg * (pi / 180);

  double calculateFare(double distance, String vehicleType) {
    double rate;
    switch (vehicleType.toLowerCase()) {
      case 'car':
        rate = 100;
        break;
      case 'van':
        rate = 150;
        break;
      default: // Tuk
        rate = 70;
    }
    return (distance * rate).roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4F1),
      appBar: AppBar(
        title: const Text("Confirm Booking"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: pickupLatLng,
                zoom: 8.5,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("pickup"),
                  position: pickupLatLng,
                  infoWindow: InfoWindow(title: widget.pickup),
                ),
                Marker(
                  markerId: const MarkerId("destination"),
                  position: destinationLatLng,
                  infoWindow: InfoWindow(title: widget.destination),
                ),
              },
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pickup: ${widget.pickup}"),
                Text("Destination: ${widget.destination}"),
                Text("Vehicle: ${widget.vehicleType}"),
                const SizedBox(height: 10),
                Text("Distance: ${distanceKm.toStringAsFixed(2)} km"),
                Text("Estimated Fare: LKR ${price.toStringAsFixed(2)}"),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Ride confirmed!")),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RouteScreen(
                                pickup: widget.pickup,
                                destination: widget.destination,
                                vehicleNo: "ABC-1234", // Replace with actual vehicle number
                                driverPhone: "0771234567", // Replace with actual driver phone number
                              ),
                            ),
                          );
                        },
                        child: const Text("Confirm Ride"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


