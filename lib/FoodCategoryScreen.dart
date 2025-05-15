import 'package:flutter/material.dart';
//import 'SnacksScreen.dart';
//import 'StreetFoodsScreen.dart';
import 'StreetFoodsScreen.dart';
import 'TeaCoffeeScreen.dart';
//import 'TropicalFruitsScreen.dart';
import 'WesternFoodsScreen.dart';
import 'traditional_foods.dart'; // Import the separate file for each category

class FoodCategoryScreen extends StatelessWidget {
  final List<Map<String, String>> foodCategories = const[
    {'title': 'Traditional', 'image': 'assets/traditional.jpg'},
    {'title': 'Western', 'image': 'assets/western.jpg'},
    {'title': 'Tea & Coffee', 'image': 'assets/tea_coffee.jpg'},
    {'title': 'Snacks', 'image': 'assets/snaks.jpg'},
    {'title': 'Street Foods', 'image': 'assets/street_food.jpg'},
    {'title': 'Tropical Fruits', 'image': 'assets/tropical_fruits.jpg'},
  ];

  const FoodCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Categories'),
        backgroundColor: Colors.lightBlue.shade50,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: foodCategories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to respective category screen based on title
              if (foodCategories[index]['title'] == 'Traditional') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TraditionalFoodsScreen(),
                  ),
                );
              } else if (foodCategories[index]['title'] == 'Western') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WesternFoodsScreen(),
                  ),
                );
              } else if (foodCategories[index]['title'] == 'Tea & Coffee') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeaCoffeeScreen(),
                  ),
                );
              } /*else if (foodCategories[index]['title'] == 'Snacks') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SnacksScreen(),
                  ),
                );
              } */else if (foodCategories[index]['title'] == 'Street Foods') {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreetFoodsScreen(),
                  ),
                );
              } else if (foodCategories[index]['title'] == 'Tropical Fruits') {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TropicalFruitsScreen(),
                  ),
                );*/
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
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                        image: DecorationImage(
                          image: AssetImage(foodCategories[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      foodCategories[index]['title']!,
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
