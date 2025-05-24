import 'package:flutter/material.dart';
import 'Handicrafts_Screen.dart';
import 'SpicesScreen.dart';
import 'CeylonTeaScreen.dart';
import 'GemsJewelryScreen.dart';
import 'TextilesScreen.dart';
import 'AyurvedicProductsScreen.dart';

class MadeInSriLankaScreen extends StatelessWidget {
  final List<Map<String, String>> sriLankaCategories = [
    {'title': 'Handicrafts', 'image': 'assets/handicrafts.jpg'},
    {'title': 'Spices', 'image': 'assets/spices.jpg'},
    {'title': 'Ceylon Tea', 'image': 'assets/ceylon_tea.jpg'},
    {'title': 'Gems & Jewelry', 'image': 'assets/gems_jewelry.jpg'},
    {'title': 'Textiles & Batik', 'image': 'assets/textiles.jpg'},
    {'title': 'Ayurvedic Products', 'image': 'assets/ayurveda.jpg'},
  ];

  MadeInSriLankaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Made in Sri Lanka'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: sriLankaCategories.length,
        itemBuilder: (context, index) {
          String category = sriLankaCategories[index]['title']!;
          String imagePath = sriLankaCategories[index]['image']!;
          return GestureDetector(
            onTap: () {
              if (category == 'Handicrafts') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HandicraftsScreen()),
                );
              } else if (category == 'Spices') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpicesScreen()),
                );
              } else if (category == 'Ceylon Tea') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CeylonTeaScreen()),
                );
              } else if (category == 'Gems & Jewelry') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GemsJewelryScreen()),
                );
              } else if (category == 'Textiles & Batik') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TextilesScreen()),
                );
              } else if (category == 'Ayurvedic Products') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AyurvedicProductsScreen()),
                );
              }
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
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      category,
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


