import 'package:flutter/material.dart';

class TropicalFruitsScreen extends StatelessWidget {
  final List<Map<String, String>> tropicalFruits = [
    {'name': 'Mango', 'image': 'assets/mango.jpg'},
    {'name': 'Papaya', 'image': 'assets/papaya.jpg'},
    {'name': 'Banana', 'image': 'assets/banana.jpg'},
    {'name': 'Pineapple', 'image': 'assets/Pineapple.jpg'},
    {'name': 'Watermelon', 'image': 'assets/watermelon.jpg'},
    {'name': 'Rambutan', 'image': 'assets/rambutan.JPG'},
    {'name': 'Wood Apple', 'image': 'assets/wood_apple.jpeg'},
    {'name': 'King Coconut', 'image': 'assets/king_coconut.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tropical Fruits')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: tropicalFruits.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TropicalFruitDetailScreen(
                    fruit: tropicalFruits[index],
                  ),
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
                          image: AssetImage(tropicalFruits[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      tropicalFruits[index]['name']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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

class TropicalFruitDetailScreen extends StatelessWidget {
  final Map<String, String> fruit;

  TropicalFruitDetailScreen({required this.fruit});

  final Map<String, String> fruitDescriptions = {
    'Mango': '''
Mango is a sweet and juicy tropical fruit with a large pit.

• Often enjoyed in smoothies, desserts, or as a fresh snack  
• Rich in vitamins and antioxidants  
• Can be eaten raw or ripe  
• A tropical favorite, known as the "king of fruits"
''',
    'Papaya': '''
Papaya is a soft, orange-colored fruit with black seeds.

• Known for its sweet taste and high vitamin C content  
• Often used in tropical salads  
• Can be eaten raw or made into juice  
• A rich source of enzymes like papain, aiding digestion
''',
    'Banana': '''
Banana is a sweet, elongated fruit, usually yellow when ripe.

• Packed with potassium and great for heart health  
• A quick snack or a great base for smoothies  
• Can be eaten raw, in baked goods, or in savory dishes  
• Known for its energy-boosting properties
''',
    'Pineapple': '''
Pineapple is a tropical fruit with a tough skin and sweet, tangy flavor.

• Often eaten fresh or used in juices, baking, or cooking  
• High in vitamin C and bromelain, an enzyme with anti-inflammatory properties  
• Can be grilled, juiced, or added to fruit salads  
• A great addition to tropical dishes or salsas
''',
    'Watermelon': '''
Watermelon is a large, juicy fruit with a green rind and red, sweet flesh.

• Perfect for hot days and outdoor snacks  
• Packed with hydration and vitamins A, B6, and C  
• Often eaten fresh, in juices or fruit salads  
• A summertime favorite in Sri Lanka
''',
    'Rambutan': '''
Rambutan is a hairy-skinned tropical fruit with sweet, white flesh inside.

• Grown widely in Sri Lanka  
• Juicy and mildly acidic  
• Related to lychee  
• Great as a refreshing snack or in fruit mixes
''',
    'Wood Apple': '''
Wood Apple is a hard-shelled fruit with tangy, aromatic pulp.

• Used in juices, chutneys, and desserts  
• Rich in antioxidants and dietary fiber  
• Known locally as "Divul"  
• Popular during dry seasons for hydration
''',
    'King Coconut': '''
King Coconut is a variety of coconut native to Sri Lanka, known for its refreshing water.

• Naturally sweet and rich in electrolytes  
• Consumed directly from the shell  
• Often sold roadside across the island  
• A natural remedy for dehydration and heatstroke
''',
  };

  @override
  Widget build(BuildContext context) {
    final String fruitName = fruit['name'] ?? '';
    final String fruitImage = fruit['image'] ?? '';
    final String description = fruitDescriptions[fruitName] ?? 'No description available.';

    return Scaffold(
      appBar: AppBar(title: Text(fruitName)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              fruitImage,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FruitMapScreen(fruitName: fruitName),
                  ),
                );
              },
              child: Text('Find Nearby Places'),
            ),
          ],
        ),
      ),
    );
  }
}

class FruitMapScreen extends StatelessWidget {
  final String fruitName;

  FruitMapScreen({required this.fruitName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Places for $fruitName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.place, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Map will be displayed here.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
