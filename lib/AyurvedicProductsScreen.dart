import 'package:flutter/material.dart';

class AyurvedicProductsScreen extends StatelessWidget {
  final List<Map<String, String>> ayurvedicItems = [
    {'name': 'Herbal Oils', 'image': 'assets/herbal_oils.jpg'},
    {'name': 'Ayurvedic Pills', 'image': 'assets/ayurvedic_pills.jpg'},
    {'name': 'Balms & Creams', 'image': 'assets/balms_creams.jpg'},
    {'name': 'Herbal Teas', 'image': 'assets/herbal_teas.jpg'},
  ];

  AyurvedicProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ayurvedic Products')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: ayurvedicItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AyurvedicDetailScreen(product: ayurvedicItems[index]),
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
                          image: AssetImage(ayurvedicItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      ayurvedicItems[index]['name']!,
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

class AyurvedicDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  AyurvedicDetailScreen({required this.product, super.key});

  final Map<String, String> productDescriptions = {
    'Herbal Oils': 'Herbal oils are used for massages and treatments.',
    'Ayurvedic Pills': 'Ayurvedic pills help maintain balance in the body.',
    'Balms & Creams': 'Topical products used for muscle and joint pain relief.',
    'Herbal Teas': 'Herbal teas promote relaxation and wellness.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name']!)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                productDescriptions[product['name']] ?? 'No description available.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AyurvedicMapScreen(productName: product['name']!),
                  ),
                );
              },
              child: Text('Find Nearby Stores'),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class AyurvedicMapScreen extends StatelessWidget {
  final String productName;

  const AyurvedicMapScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stores for $productName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_hospital, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text('Map will be displayed here.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
