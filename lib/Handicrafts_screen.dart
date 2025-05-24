import 'package:flutter/material.dart';
import 'handicraft_map_screen.dart'; // <-- Import the map screen here

class HandicraftsScreen extends StatelessWidget {
  final List<Map<String, String>> handicraftItems = [
    {'name': 'Lacquer Work', 'image': 'assets/lacquer_work.jpg'},
    {'name': 'Beeralu Lace', 'image': 'assets/beeralu_lace.jpg'},
    {'name': 'Brassware', 'image': 'assets/brassware.jpg'},
    {'name': 'Wood Carving', 'image': 'assets/wood_carving.jpg'},
  ];

  HandicraftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Handicrafts')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: handicraftItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HandicraftDetailScreen(item: handicraftItems[index]),
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
                          image: AssetImage(handicraftItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      handicraftItems[index]['name']!,
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

class HandicraftDetailScreen extends StatelessWidget {
  final Map<String, String> item;

  HandicraftDetailScreen({super.key, required this.item});

  final Map<String, String> itemDescriptions = {
    'Lacquer Work': 'Lacquer work involves decorative designs using colored resin.',
    'Beeralu Lace': 'Beeralu lace is an intricate bobbin lace made by hand using fine threads.',
    'Brassware': 'Brassware involves crafting decorative and functional items from brass metal.',
    'Wood Carving': 'Wood carving is the art of shaping wood into beautiful decorative or functional objects.',
  };

  @override
  Widget build(BuildContext context) {
    final description = itemDescriptions[item['name']] ?? 'Description not available.';

    return Scaffold(
      appBar: AppBar(title: Text(item['name']!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item['image']!),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HandicraftMapScreen(itemName: item['name']!),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text('Find Nearby Places'),
            ),
          ],
        ),
      ),
    );
  }
}

























