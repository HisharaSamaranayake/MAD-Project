import 'package:flutter/material.dart';

class RideConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String vehicle =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: const Color(0xFFE6F7F2),
      appBar: AppBar(
        title: const Text('Confirm Ride'),
        backgroundColor: const Color.fromARGB(255, 182, 219, 217),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'You selected: $vehicle',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ride Confirmed!')),
                  );
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 157, 204, 201),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('Confirm Ride'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
