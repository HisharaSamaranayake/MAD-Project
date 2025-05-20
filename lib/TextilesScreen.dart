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
                  builder: (context) =>
                      TextileDetailScreen(textile: textileItems[index]),
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

class TextileDetailScreen extends StatelessWidget {
  final Map<String, String> textile;

  TextileDetailScreen({super.key, required this.textile});

  final Map<String, String> textileDescriptions = {
    'Batik': '''Batik is a unique textile art using wax-resistant dyeing. Features:

• Colorful patterns and floral designs  
• Handcrafted with wax and dye  
• Popular for dresses, shirts, and wall hangings  
• Found in places like Kandy and Galle''',
    'Handloom': '''Handloom textiles are woven using traditional methods. Highlights:

• Crafted on manual looms  
• Bright stripes and natural dyes  
• Used in saris, bags, and home décor  
• Supports rural artisans''',
    'Kandyan Saree': '''The Kandyan Saree (Osariya) is traditional attire worn by Sri Lankan women:

• Draped in a unique style from Kandy  
• Symbol of elegance and tradition  
• Often worn at ceremonies and weddings  
• Features rich fabric and borders''',
    'Sarong': '''Sarongs are versatile wrap-around garments worn by men and women:

• Comfortable and breathable  
• Comes in colorful checks and patterns  
• Worn for daily use or traditional events  
• Common in coastal and village areas''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(textile['name']!)),
      body: Column(
        children: [
          Image.asset(textile['image']!,
              width: double.infinity, height: 250, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              textileDescriptions[textile['name']]!,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TextileMapScreen(textileName: textile['name']!),
                ),
              );
            },
            child: Text('Find Shops Nearby'),
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
// TODO Implement this library.