import 'package:flutter/material.dart';

class SpicesScreen extends StatelessWidget {
  final List<Map<String, String>> spiceItems = [
    {'name': 'Cinnamon', 'image': 'assets/cinnamon.jpg'},
    {'name': 'Cardamom', 'image': 'assets/cardamom.jpg'},
    {'name': 'Cloves', 'image': 'assets/cloves.jpg'},
    {'name': 'Black Pepper', 'image': 'assets/black_pepper.jpg'},
  ];

  SpicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Spices')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: spiceItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpiceDetailScreen(spice: spiceItems[index]),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        image: DecorationImage(
                          image: AssetImage(spiceItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      spiceItems[index]['name']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SpiceDetailScreen extends StatelessWidget {
  final Map<String, String> spice;

  SpiceDetailScreen({required this.spice, super.key});

  final Map<String, String> spiceDescriptions = {
    'Cinnamon': 'Sri Lanka produces some of the world’s finest cinnamon, known for its sweet flavor and aroma.',
    'Cardamom': 'Often referred to as the "Queen of Spices", Sri Lankan cardamom is prized for its strong aroma.',
    'Cloves': 'Used widely in cooking and ayurvedic medicine, cloves from Sri Lanka are rich in oil.',
    'Black Pepper': 'Sri Lankan black pepper is bold and pungent, perfect for enhancing savory dishes.',
  };

  @override
  Widget build(BuildContext context) {
    String spiceName = spice['name'] ?? 'Spice';
    String description = spiceDescriptions[spiceName] ?? 'No description available.';

    return Scaffold(
      appBar: AppBar(title: Text(spiceName)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(spice['image']!, width: double.infinity, height: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpiceMapScreen(spiceName: spiceName),
                  ),
                );
              },
              child: Text('Find Nearby Places'),
            ),
          ),
        ],
      ),
    );
  }
}

class SpiceMapScreen extends StatelessWidget {
  final String spiceName;

  const SpiceMapScreen({required this.spiceName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Places for $spiceName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.place, size: 100, color: Colors.deepOrange),
            SizedBox(height: 20),
            Text('Map will be displayed here.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
