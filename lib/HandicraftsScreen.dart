import 'package:flutter/material.dart';

class HandicraftsScreen extends StatelessWidget {
  final List<Map<String, String>> handicraftItems = [
    {'name': 'Lacquer Work', 'image': 'assets/lacquer_work.jpg'},
    {'name': 'Beeralu Lace', 'image': 'assets/beeralu_lace.jpg'},
    {'name': 'Brassware', 'image': 'assets/brassware.jpg'},
    {'name': 'Wood Carving', 'image': 'assets/wood_carving.jpg'},
  ];

  const HandicraftsScreen({super.key});

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
                  builder:
                      (context) =>
                          HandicraftDetailScreen(item: handicraftItems[index]),
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
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        image: DecorationImage(
                          image: AssetImage(handicraftItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      handicraftItems[index]['name']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
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
    'Lacquer Work':
        '''Lacquer work is a vibrant and traditional decorative art form in Sri Lanka. Key aspects:

â€¢ Bright-colored patterns on wood and bamboo  
â€¢ Applied using melted resin and dyes  
â€¢ Common in Matale and Kandy  
â€¢ Used for ornaments, walking sticks, and containers''',
    'Beeralu Lace':
        '''Beeralu lace is a delicate handmade lacework tradition. Highlights include:

â€¢ Created using wooden bobbins  
â€¢ Introduced during the Portuguese era  
â€¢ Crafted in coastal areas like Galle  
â€¢ Common in tablecloths, dresses, and curtains''',
    'Brassware':
        '''Brassware involves the crafting of artistic and functional brass items. Details:

â€¢ Includes lamps, trays, vases, and religious statues  
â€¢ Features detailed engraving and embossing  
â€¢ Prominent in Kandy and central highlands  
â€¢ Reflects traditional Sinhala Buddhist aesthetics''',
    'Wood Carving':
        '''Wood carving is a heritage art in Sri Lanka with spiritual significance. Features include:

â€¢ Intricate patterns on doors, windows, and pillars  
â€¢ Used in temples and homes  
â€¢ Made with tools passed down generations  
â€¢ Rich in floral and animal motifs''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item['name']!)),
      body: Column(
        children: [
          Image.asset(
            item['image']!,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              itemDescriptions[item['name']]!,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => HandicraftMapScreen(itemName: item['name']!),
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

class HandicraftMapScreen extends StatelessWidget {
  final String itemName;

  const HandicraftMapScreen({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Places for $itemName')),
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