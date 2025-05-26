import 'package:flutter/material.dart';
import 'ride_confirmation_screen.dart'; // import this

class VehicleSelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> vehicles = [
    {
      'name': 'Bike',
      'price': 'LKR 200',
      'icon': Icons.pedal_bike,
    },
    {
      'name': 'Car',
      'price': 'LKR 450',
      'icon': Icons.directions_car,
    },
    {
      'name': 'Tuk Tuk',
      'price': 'LKR 300',
      'icon': Icons.electric_rickshaw,
    },
    {
      'name': 'Van',
      'price': 'LKR 600',
      'icon': Icons.airport_shuttle,
    },
  ];

  VehicleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F7F2),
      appBar: AppBar(
        title: const Text('Select a Vehicle'),
        backgroundColor: const Color(0xFF317873),
      ),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFFCCF3D6),
            child: ListTile(
              leading: Icon(
                vehicle['icon'],
                size: 32,
                color: const Color(0xFF317873),
              ),
              title: Text(
                vehicle['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                vehicle['price'],
                style: const TextStyle(color: Colors.black54),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RideConfirmationScreen(),
                    settings: RouteSettings(arguments: vehicle['name']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}