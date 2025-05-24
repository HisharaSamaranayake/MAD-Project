import 'package:flutter/material.dart';

class GemsJewelryScreen extends StatelessWidget {
  final List<Map<String, String>> gemItems = [
    {'name': 'Blue Sapphire', 'image': 'assets/blue_sapphire.jpg'},
    {'name': 'Ruby', 'image': 'assets/ruby.jpg'},
    {'name': 'Moonstone', 'image': 'assets/moonstone.jpg'},
  ];

  GemsJewelryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gems & Jewelry')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: gemItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      GemDetailScreen(gem: gemItems[index]),
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
                          image: AssetImage(gemItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      gemItems[index]['name']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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

class GemDetailScreen extends StatelessWidget {
  final Map<String, String> gem;

  GemDetailScreen({super.key, required this.gem});

  final Map<String, String> gemDescriptions = {
    'Blue Sapphire': '''Known as the "Gem of Heaven", Ceylon Blue Sapphire is:
• Deep royal blue in color  
• Found mainly in the Ratnapura region  
• Believed to bring wisdom and good fortune  
• Commonly used in high-end jewelry  
• Sri Lanka is one of the top sources globally''',

    'Ruby': '''Ceylon Rubies are radiant red gemstones that signify passion:
• Deep red to pinkish-red in color  
• Symbol of love, energy, and power  
• Found in the Elahera and Balangoda areas  
• Often set in gold or silver jewelry  
• Valued for both beauty and rarity''',

    'Moonstone': '''Sri Lankan Moonstone is admired for its glowing sheen:
• Exhibits a blue or white shimmer (adularescence)  
• Primarily found in Meetiyagoda  
• Known for calming and balancing energies  
• Used in both modern and traditional designs  
• A gemstone of emotional clarity''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gem['name']!)),
      body: Column(
        children: [
          Image.asset(gem['image']!, width: double.infinity, height: 250, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              gemDescriptions[gem['name']] ?? 'No description available.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GemMapScreen(gemName: gem['name']!),
                ),
              );
            },
            child: Text('Find Gem Shops'),
          ),
        ],
      ),
    );
  }
}

class GemMapScreen extends StatelessWidget {
  final String gemName;

  const GemMapScreen({super.key, required this.gemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gem Shops for $gemName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.store_mall_directory, size: 100, color: Colors.purple),
            SizedBox(height: 20),
            Text('Map will be displayed here.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

