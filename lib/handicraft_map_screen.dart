import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class HandicraftMapScreen extends StatefulWidget {
  final String itemName;

  const HandicraftMapScreen({super.key, required this.itemName});

  @override
  State<HandicraftMapScreen> createState() => _HandicraftMapScreenState();
}

class _HandicraftMapScreenState extends State<HandicraftMapScreen> {
  LatLng? currentLocation;
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  String travelMode = 'driving';
  LatLng? selectedShopLocation;

  final List<Map<String, dynamic>> nearbyShops = [
    {
      'name': 'Lanka Handicrafts',
      'position': LatLng(6.9271, 79.8612),
    },
    {
      'name': 'Ceylon Arts & Crafts',
      'position': LatLng(6.9319, 79.8478),
    },
    {
      'name': 'Heritage Handlooms',
      'position': LatLng(6.9154, 79.8570),
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();
    final hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      await location.requestPermission();
    }

    final locData = await location.getLocation();
    setState(() {
      currentLocation = LatLng(locData.latitude!, locData.longitude!);
    });

    for (var shop in nearbyShops) {
      markers.add(Marker(
        markerId: MarkerId(shop['name']),
        position: shop['position'],
        infoWindow: InfoWindow(title: shop['name']),
      ));
    }

    setState(() {});
  }

  Future<void> _getRouteAndShow(LatLng destination) async {
    if (currentLocation == null) return;

    final apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation!.latitude},${currentLocation!.longitude}&destination=${destination.latitude},${destination.longitude}&mode=$travelMode&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['routes'].isNotEmpty) {
      final points = data['routes'][0]['overview_polyline']['points'];
      final List<LatLng> routeCoords = _decodePolyline(points);

      setState(() {
        polylines.clear();
        polylines.add(Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.deepPurple,
          width: 5,
          points: routeCoords,
        ));
      });

      mapController?.animateCamera(CameraUpdate.newLatLngBounds(
        _boundsFromLatLngList([currentLocation!, destination]),
        100,
      ));
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double x0 = list.first.latitude;
    double x1 = list.first.latitude;
    double y0 = list.first.longitude;
    double y1 = list.first.longitude;

    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(x0, y0),
      northeast: LatLng(x1, y1),
    );
  }

  void _openInGoogleMaps(LatLng destination) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}&travelmode=$travelMode',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch Google Maps")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: currentLocation!,
                    zoom: 14,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: markers,
                  polylines: polylines,
                  onMapCreated: (controller) => mapController = controller,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Nearby Places for ${widget.itemName}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: nearbyShops.length,
                            itemBuilder: (context, index) {
                              final shop = nearbyShops[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedShopLocation = shop['position'];
                                    _getRouteAndShow(shop['position']);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.all(12),
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: selectedShopLocation == shop['position']
                                          ? Colors.teal
                                          : Colors.grey.shade300,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shop['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Address info here',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Text("Mode: ", style: TextStyle(fontWeight: FontWeight.w600)),
                              DropdownButton<String>(
                                value: travelMode,
                                items: ['driving', 'walking', 'bicycling', 'transit']
                                    .map((mode) => DropdownMenuItem(
                                          value: mode,
                                          child: Text(mode[0].toUpperCase() + mode.substring(1)),
                                        ))
                                    .toList(),
                                onChanged: (mode) {
                                  if (mode != null) {
                                    setState(() {
                                      travelMode = mode;
                                      if (selectedShopLocation != null) {
                                        _getRouteAndShow(selectedShopLocation!);
                                      }
                                    });
                                  }
                                },
                              ),
                              const Spacer(),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple.shade100,
                                ),
                                onPressed: selectedShopLocation == null
                                    ? null
                                    : () => _openInGoogleMaps(selectedShopLocation!),
                                icon: const Icon(Icons.navigation, color: Colors.deepPurple),
                                label: const Text(
                                  "Navigate",
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}







