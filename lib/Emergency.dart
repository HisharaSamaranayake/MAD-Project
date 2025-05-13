import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  Widget buildEmergencyCard({
    required String assetPath,
    required List<Map<String, String>> services,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      color: Colors.blue[50], // Using a light blue shade
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              assetPath,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 8),
          ...services.map((service) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: Colors.blue[100], // Slightly darker blue shade
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                leading: const Icon(
                  Icons.local_phone,
                  color: Colors.redAccent,
                  size: 28,
                ),
                title: Text(
                  service['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: Colors.black,
                    letterSpacing: 0.4,
                  ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    service['number']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFD5EBFF,
      ), // Light background for the whole screen
      appBar: AppBar(
        backgroundColor: const Color(0xFFD5EBFF),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Emergency",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 22,
            letterSpacing: 0.8,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
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
              {
                'title': 'Sri Lanka Tourism Development Authority',
                'number': '1912',
              },
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/favorites');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/home');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        ],
      ),
    );
  }
}
