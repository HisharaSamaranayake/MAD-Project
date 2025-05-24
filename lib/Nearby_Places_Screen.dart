import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NearbyPlacesScreen extends StatefulWidget {
  final String foodName;

  const NearbyPlacesScreen({super.key, required this.foodName});

  @override
  State<NearbyPlacesScreen> createState() => _NearbyPlacesScreenState();
}

class _NearbyPlacesScreenState extends State<NearbyPlacesScreen> {
  final Completer<GoogleMapController> _mapController = Completer();

  final List<Map<String, dynamic>> nearbyPlaces = [
    {
      'name': 'Kiribath House',
      'lat': 6.9271,
      'lng': 79.8612,
      'address': '123 Colombo St',
    },
    {
      'name': 'Sri Lankan Delights',
      'lat': 6.9300,
      'lng': 79.8650,
      'address': '45 Galle Rd',
    },
    {
      'name': 'Coconut Bowl',
      'lat': 6.9250,
      'lng': 79.8700,
      'address': '78 Main St',
    },
  ];

  LatLng? _currentLocation;
  LatLng? _selectedPlaceLocation;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  String _travelTime = '';
  String _travelMode = 'driving'; // 'walking' or 'driving'

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enable location services')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied')),
      );
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        return;
      }
    }

    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(pos.latitude, pos.longitude);
      _selectedPlaceLocation = LatLng(nearbyPlaces[0]['lat'], nearbyPlaces[0]['lng']);
    });

    await _updateRoute();
  }

  Future<void> _updateRoute() async {
    if (_currentLocation == null || _selectedPlaceLocation == null) return;

    final origin = '${_currentLocation!.latitude},${_currentLocation!.longitude}';
    final destination = '${_selectedPlaceLocation!.latitude},${_selectedPlaceLocation!.longitude}';
    final mode = _travelMode; // driving or walking

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&mode=$mode&key=YOUR_GOOGLE_API_KEY'
    );

    final response = await http.get(url);
    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get directions: ${response.statusCode}')),
      );
      return;
    }

    final data = jsonDecode(response.body);

    if ((data['routes'] as List).isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No routes found')),
      );
      return;
    }

    final route = data['routes'][0];
    final leg = route['legs'][0];

    final durationText = leg['duration']['text'];
    final steps = leg['steps'] as List;

    List<LatLng> polylinePoints = [];

    for (var step in steps) {
      final points = _decodePolyline(step['polyline']['points']);
      polylinePoints.addAll(points);
    }

    setState(() {
      _travelTime = durationText;

      _markers = {
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'You are here'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
        Marker(
          markerId: const MarkerId('selectedPlace'),
          position: _selectedPlaceLocation!,
          infoWindow: InfoWindow(title: nearbyPlaces.firstWhere(
            (p) =>
                p['lat'] == _selectedPlaceLocation!.latitude &&
                p['lng'] == _selectedPlaceLocation!.longitude,
            orElse: () => {'name': 'Selected Place'})['name']),
          icon: BitmapDescriptor.defaultMarker,
        ),
      };

      _polylines = {
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blue,
          width: 6,
          points: polylinePoints,
        ),
      };
    });

    await _moveCameraToFitBounds();
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  Future<void> _moveCameraToFitBounds() async {
    if (_currentLocation == null || _selectedPlaceLocation == null) return;

    final GoogleMapController controller = await _mapController.future;

    LatLngBounds bounds;

    if (_currentLocation!.latitude > _selectedPlaceLocation!.latitude &&
        _currentLocation!.longitude > _selectedPlaceLocation!.longitude) {
      bounds = LatLngBounds(
        southwest: _selectedPlaceLocation!,
        northeast: _currentLocation!,
      );
    } else if (_currentLocation!.longitude > _selectedPlaceLocation!.longitude) {
      bounds = LatLngBounds(
        southwest: LatLng(_currentLocation!.latitude, _selectedPlaceLocation!.longitude),
        northeast: LatLng(_selectedPlaceLocation!.latitude, _currentLocation!.longitude),
      );
    } else if (_currentLocation!.latitude > _selectedPlaceLocation!.latitude) {
      bounds = LatLngBounds(
        southwest: LatLng(_selectedPlaceLocation!.latitude, _currentLocation!.longitude),
        northeast: LatLng(_currentLocation!.latitude, _selectedPlaceLocation!.longitude),
      );
    } else {
      bounds = LatLngBounds(
        southwest: _currentLocation!,
        northeast: _selectedPlaceLocation!,
      );
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);
    controller.animateCamera(cameraUpdate);
  }

  Future<void> _launchGoogleMaps() async {
    if (_currentLocation == null || _selectedPlaceLocation == null) return;

    final origin = '${_currentLocation!.latitude},${_currentLocation!.longitude}';
    final destination = '${_selectedPlaceLocation!.latitude},${_selectedPlaceLocation!.longitude}';
    final mode = _travelMode;

    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=$mode',
    );

    if (!await launchUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Google Maps')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentLocation == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Places for ${widget.foodName}'),
      ),
      body: Column(
        children: [
          // Places list
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nearbyPlaces.length,
              itemBuilder: (context, index) {
                final place = nearbyPlaces[index];
                final isSelected = _selectedPlaceLocation != null &&
                    place['lat'] == _selectedPlaceLocation!.latitude &&
                    place['lng'] == _selectedPlaceLocation!.longitude;

                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      _selectedPlaceLocation =
                          LatLng(place['lat'], place['lng']);
                    });
                    await _updateRoute();
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: isSelected ? Colors.teal : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 180,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(place['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(place['address'], style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text('Mode:'),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _travelMode,
                  items: const [
                    DropdownMenuItem(value: 'driving', child: Text('Driving')),
                    DropdownMenuItem(value: 'walking', child: Text('Walking')),
                  ],
                  onChanged: (value) async {
                    if (value == null) return;
                    setState(() {
                      _travelMode = value;
                    });
                    await _updateRoute();
                  },
                ),
                const Spacer(),
                Text(
                  _travelTime.isEmpty ? '' : 'Estimated time: $_travelTime',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _launchGoogleMaps,
                  icon: const Icon(Icons.navigation),
                  label: const Text('Navigate'),
                ),
              ],
            ),
          ),

          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: 14,
              ),
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                _mapController.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }
}




