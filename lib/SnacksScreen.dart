import 'package:flutter/material.dart';

class SnacksScreen extends StatelessWidget {
  final List<Map<String, String>> snacksItems = [
    {'name': 'Mixture', 'image': 'assets/mixture.jpg'},
    {'name': 'Kokis', 'image': 'assets/kokis.jpg'},
    {'name': 'Boondi', 'image': 'assets/boondi.jpg'},
    {'name': 'Casava Chips', 'image': 'assets/casava_chips.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Snacks')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: snacksItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SnacksDetailScreen(snack: snacksItems[index]),
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
                          image: AssetImage(snacksItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      snacksItems[index]['name']!,
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

class SnacksDetailScreen extends StatelessWidget {
  final Map<String, String> snack;


  final Map<String, String> snackDescriptions = {
    'Mixture': '''Mixture is a crunchy, spicy snack mix combining various fried ingredients. Highlights include:

• Fried lentils, peanuts, and chickpea flour noodles  
• Seasoned with curry leaves and spices  
• A favorite tea-time snack  
• Widely sold in packets across Sri Lanka''',
    'Kokis': '''Kokis is a traditional Sri Lankan deep-fried snack made with rice flour. Key features:

• Shaped with a special mold into floral or wheel-like patterns  
• Made from rice flour and coconut milk  
• Deep-fried until golden and crispy  
• Popular during Sinhala and Tamil New Year''',
    'Boondi': '''Boondi is a sweet or savory snack made from tiny deep-fried chickpea flour droplets. It includes:

• Small, crispy, round balls  
• Can be spicy or sweet  
• Often included in mixtures  
• Enjoyed during festivals and celebrations''',
    'Casava Chips': '''Casava chips are thinly sliced and deep-fried pieces of cassava root. Popular aspects:

• Crispy texture and golden color  
• Lightly salted or spiced  
• Commonly sold in snack shops and fairs  
• A simple yet addictive snack''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(snack['name']!)),
      body: Column(
        children: [
          Image.asset(snack['image']!,
              width: double.infinity, height: 250, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              snackDescriptions[snack['name']]!,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SnacksMapScreen(snackName: snack['name']!),
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

class SnacksMapScreen extends StatelessWidget {
  final String snackName;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Places for $snackName')),
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
