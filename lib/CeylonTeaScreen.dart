import 'package:flutter/material.dart';

class CeylonTeaScreen extends StatelessWidget {
  final List<Map<String, String>> teaItems = [
    {'name': 'Black Tea', 'image': 'assets/black_tea.jpg'},
    {'name': 'Green Tea', 'image': 'assets/green_tea.jpg'},
    {'name': 'White Tea', 'image': 'assets/white_tea.jpg'},
    {'name': 'Herbal Infusions', 'image': 'assets/herbal_tea.jpg'},
  ];

  const CeylonTeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ceylon Tea')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: teaItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeaDetailScreen(tea: teaItems[index]),
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
                          image: AssetImage(teaItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      teaItems[index]['name']!,
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

class TeaDetailScreen extends StatelessWidget {
  final Map<String, String> tea;

  TeaDetailScreen({super.key, required this.tea});

  final Map<String, String> teaDescriptions = {
    'Black Tea':
        '''Ceylon Black Tea is the most popular tea in Sri Lanka. Features include:

â€¢ Rich in color and strong in flavor  
â€¢ Grown mainly in Uva, Dimbula, and Nuwara Eliya regions  
â€¢ Often enjoyed with milk or sugar  
â€¢ Used in breakfast blends worldwide''',
    'Green Tea':
        '''Ceylon Green Tea is known for its delicate taste and health benefits:

â€¢ Light and refreshing flavor  
â€¢ Minimal oxidation during processing  
â€¢ Rich in antioxidants  
â€¢ Commonly consumed for weight loss and wellness''',
    'White Tea':
        '''Ceylon White Tea is the rarest and most prized variety. It is:

â€¢ Made from young tea buds  
â€¢ Extremely light and subtle in taste  
â€¢ Hand-picked and sun-dried  
â€¢ Grown mostly in Nuwara Eliya''',
    'Herbal Infusions':
        '''These are caffeine-free blends made with herbs and spices:

â€¢ Includes chamomile, lemongrass, and cinnamon blends  
â€¢ Known for calming and digestive benefits  
â€¢ Naturally sweet and aromatic  
â€¢ Often served in wellness retreats''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tea['name']!)),
      body: Column(
        children: [
          Image.asset(
            tea['image']!,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              teaDescriptions[tea['name']]!,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeaMapScreen(teaName: tea['name']!),
                ),
              );
            },
            child: Text('Find Tea Estates'),
          ),
        ],
      ),
    );
  }
}

class TeaMapScreen extends StatelessWidget {
  final String teaName;

  const TeaMapScreen({super.key, required this.teaName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tea Estates for $teaName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.terrain, size: 100, color: Colors.brown),
            SizedBox(height: 20),
            Text('Map will be displayed here.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
// TODO Implement this library.