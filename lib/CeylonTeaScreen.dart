import 'package:flutter/material.dart';

class CeylonTeaScreen extends StatelessWidget {
  final List<Map<String, String>> teaItems = [
    {'name': 'Black Tea', 'image': 'assets/black_tea.jpg'},
    {'name': 'Green Tea', 'image': 'assets/green_tea.jpg'},
    {'name': 'White Tea', 'image': 'assets/white_tea.jpg'},
    {'name': 'Herbal Infusions', 'image': 'assets/herbal_tea.jpg'},
  ];

  CeylonTeaScreen({super.key});

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
                  builder: (_) => TeaDetailScreen(tea: teaItems[index]),
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
    'Black Tea': 'Bold and rich, the traditional favorite of Sri Lanka.',
    'Green Tea': 'Delicate and refreshing with a light grassy flavor.',
    'White Tea': 'Smooth and subtle with the least oxidation.',
    'Herbal Infusions': 'Caffeine-free blends using native herbs and spices.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tea['name']!)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                teaDescriptions[tea['name']] ?? 'No description available.',
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
                    builder: (_) => TeaMapScreen(teaName: tea['name']!),
                  ),
                );
              },
              child: Text('Find Tea Estates'),
            ),
          ),
          SizedBox(height: 20),
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
