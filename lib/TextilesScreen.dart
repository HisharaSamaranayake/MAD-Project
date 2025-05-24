import 'package:flutter/material.dart';

class TextilesScreen extends StatelessWidget {
  final List<Map<String, String>> textileItems = [
    {'name': 'Batik', 'image': 'assets/batik.jpg'},
    {'name': 'Handloom', 'image': 'assets/handloom.jpg'},
    {'name': 'Kandyan Saree', 'image': 'assets/kandyan_saree.jpg'},
    {'name': 'Sarong', 'image': 'assets/sarong.jpg'},
  ];

  TextilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Textiles')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: textileItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TextileDetailScreen(textile: textileItems[index]),
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
                          image: AssetImage(textileItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      textileItems[index]['name']!,
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

class TextileDetailScreen extends StatelessWidget {
  final Map<String, String> textile;

  TextileDetailScreen({super.key, required this.textile});

  final Map<String, String> textileDescriptions = {
    'Batik': 'Batik is a traditional Sri Lankan textile art using wax-resist dyeing techniques.',
    'Handloom': 'Handloom textiles are made on traditional looms and showcase vibrant Sri Lankan colors.',
    'Kandyan Saree': 'A traditional dress worn by Kandyan women, rich in culture and elegance.',
    'Sarong': 'A sarong is a versatile garment worn by both men and women, especially in tropical climates.',
  };

  @override
  Widget build(BuildContext context) {
    String textileName = textile['name'] ?? 'Textile';
    String description = textileDescriptions[textileName] ?? 'No description available.';

    return Scaffold(
      appBar: AppBar(title: Text(textileName)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(textile['image']!, width: double.infinity, height: 200, fit: BoxFit.cover),
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
                    builder: (context) => TextileMapScreen(textileName: textileName),
                  ),
                );
              },
              child: Text('Find Shops Nearby'),
            ),
          ),
        ],
      ),
    );
  }
}

class TextileMapScreen extends StatelessWidget {
  final String textileName;

  const TextileMapScreen({super.key, required this.textileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shops for $textileName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 100, color: Colors.teal),
            SizedBox(height: 20),
            Text('Map will be displayed here.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
