import 'package:flutter/material.dart';
import 'confirm_booking_screen.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({super.key});

  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();
  String selectedVehicle = 'Tuk';

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Full white background
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFB2DFDB), // Light mint green top bar
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Travel",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildInputField("Your location", pickupController),
                    const SizedBox(height: 16),
                    _buildInputField("Where are you going?", destinationController),
                    const SizedBox(height: 24),

                    const Text("Select Vehicle:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),

                    Row(
                      children: _vehicleTypes.map((vehicle) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(vehicle['icon'], size: 18, color: Colors.black),
                                const SizedBox(width: 4),
                                Text(vehicle['label']),
                              ],
                            ),
                            selected: selectedVehicle == vehicle['label'],
                            selectedColor: const Color(0xFFB2DFDB),
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            onSelected: (selected) {
                              setState(() {
                                selectedVehicle = vehicle['label'];
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),

                    const Spacer(),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (pickupController.text.isNotEmpty && destinationController.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ConfirmBookingScreen(
                                  pickup: pickupController.text,
                                  destination: destinationController.text,
                                  vehicleType: selectedVehicle,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please fill in both fields")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00796B), // Teal
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                        child: const Text("Search", style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Add navigation if needed
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.grey[100],
        filled: true,
        border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
      ),
    );
  }

  final List<Map<String, dynamic>> _vehicleTypes = [
    {'label': 'Tuk', 'icon': Icons.two_wheeler},
    {'label': 'Car', 'icon': Icons.directions_car},
    {'label': 'Van', 'icon': Icons.directions_bus},
  ];
}
