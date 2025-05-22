import 'package:flutter/material.dart';

class GemsJewelryScreen extends StatelessWidget {
  final List<Map<String, String>> gemItems = [
    {'name': 'Blue Sapphire', 'image': 'assets/blue_sapphire.jpg'},
    {'name': 'Ruby', 'image': 'assets/ruby.jpg'},
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


  final Map<String, String> gemDescriptions = {
    'Blue Sapphire': '''Known as the "Gem of Heaven", Ceylon Blue Sapphire is:

    'Ruby': '''Ceylon Rubies are radiant red gemstones that signify passion:


    'Moonstone': '''Sri Lankan Moonstone is admired for its glowing sheen:

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gem['name']!)),
      body: Column(
        children: [
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