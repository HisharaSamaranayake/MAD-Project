import 'package:flutter/material.dart';

class GemsJewelryScreen extends StatelessWidget {
  final List<Map<String, String>> gemItems = [
    {'name': 'Blue Sapphire', 'image': 'assets/blue_sapphire.jpg'},
    {'name': 'Ruby', 'image': 'assets/ruby.jpg'},
    {'name': 'Cat’s Eye', 'image': 'assets/cats_eye.jpg'},
    {'name': 'Moonstone', 'image': 'assets/moonstone.jpg'},
  ];

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
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
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

class GemDetailScreen extends StatelessWidget {
  final Map<String, String> gem;

  GemDetailScreen({required this.gem});

  final Map<String, String> gemDescriptions = {
    'Blue Sapphire': '''Known as the "Gem of Heaven", Ceylon Blue Sapphire is:

• Highly prized for its deep blue color  
• Found in Ratnapura, Sri Lanka’s “City of Gems”  
• Often used in royal and luxury jewelry  
• A symbol of wisdom, wealth, and divine favor''',
    'Ruby': '''Ceylon Rubies are radiant red gemstones that signify passion:

• Famous for their fiery hue  
• Rare and highly valuable  
• Traditionally associated with power and love  
• Found in southern and central Sri Lanka''',
    'Cat’s Eye': '''Cat’s Eye, or Chrysoberyl, is a mystical and unique gem:

• Displays a bright reflective band like a cat’s eye  
• Believed to bring protection and prosperity  
• Typically honey-yellow to greenish in color  
• Highly regarded in astrology''',
    'Moonstone': '''Sri Lankan Moonstone is admired for its glowing sheen:

• Found mainly in Meetiyagoda  
• Shows a bluish-white shimmer (adularescence)  
• Considered a symbol of peace and femininity  
• Popular in handcrafted silver jewelry''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gem['name']!)),
      body: Column(
        children: [
          Image.asset(gem['image']!,
              width: double.infinity, height: 250, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              gemDescriptions[gem['name']]!,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      GemMapScreen(gemName: gem['name']!),
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

  GemMapScreen({required this.gemName});

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
// TODO Implement this library.