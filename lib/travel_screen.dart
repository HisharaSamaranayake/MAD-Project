import 'package:flutter/material.dart';
import 'vehicle_selection_screen.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({super.key});

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  final locationController = TextEditingController();
  final destinationController = TextEditingController();

  @override
  void dispose() {
    locationController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F7F2),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Travel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  color: const Color.fromARGB(255, 14, 61, 32),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCF3D6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.place, color: Color(0xFF317873)),
                        hintText: 'Your location',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCF3D6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: destinationController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.place, color: Color(0xFF317873)),
                        hintText: 'Where are you going?',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD8ECF2),
                  foregroundColor: Colors.grey,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  if (locationController.text.isNotEmpty &&
                      destinationController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VehicleSelectionScreen(),
                      ),
                    );
                  }
                },
                child: const Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

