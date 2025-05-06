import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  Widget buildEmergencyCard({
    required String assetPath,
    required List<Map<String, String>> services,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(assetPath),
          ),
          ...services.map((service) => ListTile(
            leading: const Icon(Icons.call),
            title: Text(service['title']!),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                service['number']!,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        centerTitle: true,
        elevation: 0,
        title: const Text("Emergency"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      // Removed drawer here
      body: ListView(
        children: [
          buildEmergencyCard(
            assetPath: 'assets/119.png',
            services: [
              {'title': 'Police Emergency Service', 'number': '119'},
              {'title': 'Emergency Information Service', 'number': '118'},
            ],
          ),
          buildEmergencyCard(
            assetPath: 'assets/1990.jpg',
            services: [
              {'title': '1990 Suwa Seriya Foundation', 'number': '1990'},
            ],
          ),
          buildEmergencyCard(
            assetPath: 'assets/1912.png',
            services: [
              {'title': 'Sri Lanka Tourism Development Authority', 'number': '1912'},
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            // Placeholder: favorites
          } else if (index == 1) {
            Navigator.pushNamed(context, '/home');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        ],
      ),
    );
  }
}