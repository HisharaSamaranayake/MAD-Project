import 'package:flutter/material.dart';
import 'HandicraftsScreen.dart';
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
          return GestureDetector(
            onTap: () {
              String category = sriLankaCategories[index]['title']!;
              if (category == 'Handicrafts') {
              } else if (category == 'Spices') {
              } else if (category == 'Ceylon Tea') {
              } else if (category == 'Gems & Jewelry') {
              } else if (category == 'Textiles & Batik') {
              } else if (category == 'Ayurvedic Products') {
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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      sriLankaCategories[index]['title']!,
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
