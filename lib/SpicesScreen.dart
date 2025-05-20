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
                  builder: (context) =>
                      SpiceDetailScreen(spice: spiceItems[index]),
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
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
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
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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

  SpiceDetailScreen({super.key, required this.spice});

  final Map<String, String> spiceDescriptions = {
    'Cinnamon': '''Sri Lankan cinnamon (Ceylon cinnamon) is known as the world's finest. Features:

• Thin, smooth bark with a sweet aroma  
• Common in desserts, curries, and teas  
• Exported globally  
• Grown mainly in the southern coast''',
    'Cardamom': '''Cardamom is a fragrant spice used in sweet and savory dishes. Characteristics:

• Small green pods with tiny black seeds  
• Strong aroma and slightly sweet taste  
• Used in curries, desserts, and herbal drinks  
• Grown in the hill country''',
    'Cloves': '''Cloves are dried flower buds with a strong, pungent flavor. Highlights:

• Used in rice dishes and spice blends  
• Contains essential oils with medicinal value  
• Grown in moist, tropical climates  
• Key ingredient in Sri Lankan curry powder''',
    'Black Pepper': '''Black pepper is a bold spice used for seasoning. Key aspects:

• Grown widely in Sri Lanka's wet zones  
• Sharp, hot flavor used in nearly every dish  
• Integral to spice blends and pickles  
• Known as the "King of Spices"''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(spice['name']!)),
      body: Column(
        children: [
          Image.asset(spice['image']!,
              width: double.infinity, height: 250, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              spiceDescriptions[spice['name']]!,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SpiceMapScreen(spiceName: spice['name']!),
                ),
              );
            },
            child: Text('Find Nearby Places'),
          ),
        ],
      ),
    );
  }
}

class SpiceMapScreen extends StatelessWidget {
  final String spiceName;

  const SpiceMapScreen({super.key, required this.spiceName});

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
// TODO Implement this library.