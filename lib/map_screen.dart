import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLocation;
  LatLng? _destination;
  final TextEditingController _destinationController = TextEditingController();

  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    _mapController.move(_currentLocation!, 15);
  }

  void _setDestination() {
    // TODO: Replace with real geocoding or a fixed lookup
    final input = _destinationController.text.trim().toLowerCase();

    // For demo, we simulate a fixed coordinate (e.g., "colombo")
    if (input == "colombo") {
      setState(() {
        _destination = LatLng(6.9271, 79.8612); // Colombo coordinates
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destination not found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<LatLng> routePoints = [];
    if (_currentLocation != null && _destination != null) {
      routePoints = [_currentLocation!, _destination!];
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Offline Map")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _getCurrentLocation,
                  child: const Text("Locate Me"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _destinationController,
                    decoration: const InputDecoration(
                      labelText: "Enter destination",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _setDestination,
                ),
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation ?? LatLng(7.8731, 80.7718), // Default SL center
                initialZoom: 6.5,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.app',
                ),
                if (_currentLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 60,
                        height: 60,
                        point: _currentLocation!,
                        child: const Icon(Icons.my_location,
                            color: Colors.blue, size: 40),
                      ),
                    ],
                  ),
                if (_destination != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 60,
                        height: 60,
                        point: _destination!,
                        child: const Icon(Icons.place,
                            color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                if (routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routePoints,
                        strokeWidth: 4.0,
                        color: Colors.green,
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







