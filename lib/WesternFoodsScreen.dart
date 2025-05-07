import 'package:flutter/material.dart';

class WesternFoodsScreen extends StatelessWidget {
  final List<Map<String, String>> westernFoods = const[
    {'name': 'Pizza', 'image': 'assets/pizza.jpg'},
    {'name': 'Burger', 'image': 'assets/burger.jpeg'},
    {'name': 'Pasta', 'image': 'assets/pasta.jpg'},
    {'name': 'Fries', 'image': 'assets/fries.jpg'},
  ];

  const WesternFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Western Foods')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: westernFoods.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WesternFoodDetailScreen(food: westernFoods[index]),
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
                          image: AssetImage(westernFoods[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      westernFoods[index]['name']!,
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

class WesternFoodDetailScreen extends StatelessWidget {
  final Map<String, String> food;

  WesternFoodDetailScreen({super.key, required this.food});

  final Map<String, String> foodDescriptions = {
    'Pizza': '''
Pizza is an Italian-origin dish made of a round dough base.

• Topped with tomato sauce, cheese, and various ingredients like:
  - Vegetables  
  - Meats  
  - Spices  

• Baked at high heat to achieve a crispy crust  
• Popular worldwide, served as:
  - Personal-sized pizza  
  - Large family pizza
''',
    'Burger': '''
A burger is a sandwich with one or more cooked patties placed inside a sliced bun.

• Can include ingredients like:
  - Cheese  
  - Lettuce  
  - Pickles  
  - Condiments (ketchup, mustard)  

• Types include:
  - Beef Burger  
  - Chicken Burger  
  - Veggie Burger  
• Served with fries or a side salad
''',
    'Pasta': '''
Pasta is a traditional Italian dish made from wheat dough.

• Comes in many shapes like:
  - Spaghetti  
  - Penne  
  - Fusilli  

• Often served with various types of sauces like:
  - Tomato-based  
  - Creamy Alfredo  
  - Pesto  
• Can be a main dish or a side dish to meats or seafood
''',
    'Fries': '''
Fries are deep-fried strips of potatoes, crispy outside and soft inside.

• Typically served as:
  - A snack  
  - A side dish to burgers, sandwiches, or grilled meats  

• Can be seasoned with:
  - Salt  
  - Pepper  
  - Garlic  
  - Paprika
''',
  };

  @override
  Widget build(BuildContext context) {
    final String foodName = food['name']!;
    final String foodImage = food['image']!;
    final String description = foodDescriptions[foodName] ?? 'No description available.';

    return Scaffold(
      appBar: AppBar(title: Text(foodName)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              foodImage,
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
                    builder: (context) =>
                        WesternFoodMapScreen(foodName: foodName),
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

class WesternFoodMapScreen extends StatelessWidget {
  final String foodName;

  const WesternFoodMapScreen({super.key, required this.foodName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Places for $foodName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 100, color: Colors.blue),
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
