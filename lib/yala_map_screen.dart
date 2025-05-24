import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class YalaMapScreen extends StatefulWidget {
  const YalaMapScreen({super.key});

  @override
  _YalaMapScreenState createState() => _YalaMapScreenState();
}

class _YalaMapScreenState extends State<YalaMapScreen> {
  late GoogleMapController mapController;
  final Location location = Location();

  LatLng? currentLocation;
  final LatLng yalaLocation = LatLng(6.3596, 81.4778); // Yala National Park coordinates

  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];

  final String googleApiKey = 'YOUR_GOOGLE_API_KEY_HERE';

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final locData = await location.getLocation();
    setState(() {
      currentLocation = LatLng(locData.latitude!, locData.longitude!);
    });
    _getDirections();
  }

  Future<void> _getDirections() async {
    if (currentLocation == null) return;

    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation!.latitude},${currentLocation!.longitude}&destination=${yalaLocation.latitude},${yalaLocation.longitude}&key=$googleApiKey';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {
      final route = data['routes'][0];
      final overviewPolyline = route['overview_polyline']['points'];
      polylineCoordinates = _decodePolyline(overviewPolyline);

      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 5,
        ));
      });
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
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

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route to Yala National Park'),
      ),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 12,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: {
                Marker(markerId: MarkerId('currentLocation'), position: currentLocation!),
                Marker(markerId: MarkerId('yala'), position: yalaLocation),
              },
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
    );
  }
}
