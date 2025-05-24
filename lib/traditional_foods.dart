import 'package:flutter/material.dart';
import 'nearby_places_screen.dart'; // Import the new screen here

class TraditionalFoodsScreen extends StatelessWidget {
  final List<Map<String, String>> traditionalFoods = const [
    {'name': 'Milk Rice', 'image': 'assets/kiribath.jpeg'},
    {'name': 'String Hoppers', 'image': 'assets/string_hoppers.jpeg'},
    {'name': 'Hoppers', 'image': 'assets/hoppers.jpg'},
    {'name': 'Pol Roti', 'image': 'assets/pol_roti.jpg'},
    {'name': 'Pittu', 'image': 'assets/pittu.jpg'},
    {'name': 'Lamprais', 'image': 'assets/lamprais.jpg'},
  ];

  const TraditionalFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Traditional Foods')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: traditionalFoods.length,
        itemBuilder: (context, index) {
          final food = traditionalFoods[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TraditionalFoodDetailScreen(food: food),
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
                            const BorderRadius.vertical(top: Radius.circular(12)),
                        image: DecorationImage(
                          image: AssetImage(food['image'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      food['name'] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
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

class TraditionalFoodDetailScreen extends StatelessWidget {
  final Map<String, String> food;

  TraditionalFoodDetailScreen({super.key, required this.food});

  final Map<String, String> foodDescriptions = {
    'Milk Rice': '''
Milk Rice (Kiribath) is a traditional Sri Lankan dish made by cooking rice with coconut milk.

• Prepared for special occasions like Sinhala and Tamil New Year  
• Served in diamond shapes  
• Common accompaniments:
  - Lunu miris (spicy onion sambol)  
  - Jaggery (palm sugar)

Symbolizes prosperity and new beginnings.
''',
    'String Hoppers': '''
String Hoppers (Idiyappam) are delicate steamed rice noodle cakes.

• Made from rice flour dough pressed into noodle form and steamed  
• Served in small round portions  
• Commonly paired with:
  - Dhal curry  
  - Coconut sambol  
  - Chicken or fish curry

Popular for breakfast or dinner.
''',
    'Hoppers': '''
Hoppers (Appa) are bowl-shaped pancakes made with rice flour and coconut milk.

• Crisp around the edges and soft in the center  
• Types include:
  - Plain Hopper  
  - Egg Hopper  
  - Milk Hopper  
• Usually served with:
  - Coconut sambol  
  - Lunu miris  
  - Dhal curry
''',
    'Pol Roti': '''
Pol Roti is a Sri Lankan flatbread made from grated coconut and wheat flour.

• Often mixed with chopped onions and green chilies  
• Cooked on a hot griddle until golden brown  
• Typically eaten with:
  - Lunu miris  
  - Coconut sambol  
  - Dhal curry

Simple and satisfying!
''',
    'Pittu': '''
Pittu is a traditional Sri Lankan dish made with rice flour and grated coconut.

• Steamed in bamboo or metal cylinders  
• Layered with coconut and flour mixture  
• Served with:
  - Coconut milk (kiri hodi)  
  - Dhal curry  
  - Meat or fish curry

Hearty and popular for breakfast or dinner.
''',
    'Lamprais': '''
Lamprais is a Dutch-influenced Sri Lankan dish wrapped and baked in banana leaves.

• Rice cooked in meat stock  
• Accompanied with:
  - Meat curry  
  - Frikkadels (meatballs)  
  - Brinjal moju (eggplant pickle)  
  - Seeni sambol  
• Wrapped in banana leaf and baked

Rich in flavor and history.
''',
  };

  @override
  Widget build(BuildContext context) {
    final String foodName = food['name'] ?? '';
    final String foodImage = food['image'] ?? '';
    final String description =
        foodDescriptions[foodName] ?? 'No description available.';

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
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the combined Nearby Places screen with map & list
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NearbyPlacesScreen(foodName: foodName),
                  ),
                );
              },
              child: const Text('Find Nearby Places'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Adjust as needed
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/emergency');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Emergency'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}


