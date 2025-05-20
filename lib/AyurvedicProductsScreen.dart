import 'package:flutter/material.dart';

class AyurvedicProductsScreen extends StatelessWidget {
  final List<Map<String, String>> ayurvedicItems = [
    {'name': 'Herbal Oils', 'image': 'assets/herbal_oils.jpg'},
    {'name': 'Ayurvedic Pills', 'image': 'assets/ayurvedic_pills.jpg'},
    {'name': 'Balms & Creams', 'image': 'assets/balms_creams.jpg'},
    {'name': 'Herbal Teas', 'image': 'assets/herbal_teas.jpg'},
  ];

  const AyurvedicProductsScreen({super.key});

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
                  builder:
                      (context) =>
                          AyurvedicDetailScreen(product: ayurvedicItems[index]),
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

class AyurvedicDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  AyurvedicDetailScreen({super.key, required this.product});

  final Map<String, String> productDescriptions = {
    'Herbal Oils':
        '''Herbal oils are used in traditional treatments and massages:

â€¢ Made from natural herbs and essential oils  
â€¢ Used for pain relief, hair care, and relaxation  
â€¢ Common in Ayurvedic therapies and spas  
â€¢ Found in wellness centers and herbal shops''',
    'Ayurvedic Pills': '''Ayurvedic pills help maintain balance in the body:

â€¢ Made with herbal extracts  
â€¢ Used to treat common ailments  
â€¢ No harmful chemicals  
â€¢ Must be taken under Ayurvedic doctor guidance''',
    'Balms & Creams': '''Topical products used for muscle and joint pain relief:

â€¢ Contain herbal ingredients like eucalyptus and camphor  
â€¢ Provide warming or cooling sensation  
â€¢ Effective for colds, headaches, and sprains  
â€¢ Widely used in homes and Ayurveda centers''',
    'Herbal Teas':
        '''Herbal teas are infused with natural ingredients for health:

â€¢ Aid digestion, relaxation, and immunity  
â€¢ Made from herbs like ginger, coriander, and cinnamon  
â€¢ Caffeine-free and refreshing  
â€¢ Available in organic shops and Ayurveda stores''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name']!)),
      body: Column(
        children: [
          Image.asset(
            product['image']!,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              productDescriptions[product['name']]!,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          AyurvedicMapScreen(productName: product['name']!),
                ),
              );
            },
            child: Text('Find Nearby Stores'),
          ),
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
// TODO Implement this library.