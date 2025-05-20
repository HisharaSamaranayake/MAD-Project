import 'package:flutter/material.dart';

class StreetFoodsScreen extends StatelessWidget {
  final List<Map<String, String>> streetFoods = [
    {'name': 'Egg Roti', 'image': 'assets/egg_roti.jpeg'},
    {'name': 'Grilled Corn', 'image': 'assets/grilled_corn.jpeg'},
    {'name': 'Pani Puri', 'image': 'assets/pani_puri.jpeg'},
    {'name': 'Vadai', 'image': 'assets/vadai.jpg'},
    {'name': 'Cutlet', 'image': 'assets/fish_cutlet.jpg'},
    {'name': 'Drumstick', 'image': 'assets/drumstick.jpg'}, // New item
  ];

  StreetFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Street Foods')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: streetFoods.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StreetFoodDetailScreen(food: streetFoods[index]),
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
                          image: AssetImage(streetFoods[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      streetFoods[index]['name']!,
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

// Street Food Detail Screen
class StreetFoodDetailScreen extends StatelessWidget {
  final Map<String, String> food;

  StreetFoodDetailScreen({super.key, required this.food});

  final Map<String, String> foodDescriptions = {
    'Egg Roti':
    '''Egg Roti is a spicy, rolled-up roti filled with egg and vegetables. It features:

• Soft, thin roti bread  
• Filled with scrambled egg, vegetables, and spices  
• A savory and satisfying street snack  
• Often served as a quick breakfast or lunch  
• Easy to eat on the go, making it a popular choice in street food markets''',
    'Grilled Corn':
    '''Grilled Corn is corn grilled over an open flame, often served with spices. Key features:

• Fresh corn on the cob grilled until crispy and smoky  
• Often brushed with butter or ghee for extra flavor  
• Spiced with chili powder, salt, or other seasonings  
• A delicious and healthy street snack  
• Popular in many street food markets, especially during the evening''',
    'Pani Puri':
    '''Pani Puri is a crispy puri filled with spicy water, potatoes, and chickpeas. Main aspects include:

• A small, hollow, crispy puri shell  
• Filled with spicy, tangy water, potatoes, and chickpeas  
• Often served with tamarind or mint chutney for extra flavor  
• A burst of flavors and textures in each bite  
• Popular in South Asia and often served as an appetizer or snack''',
    'Vadai':
    '''Vadai is a fried snack made from lentils, usually served with chutney or sambar. It comes in different varieties including:

• **Uludu Vadai** – Made with black gram lentils, shaped into rings, and deep-fried  
• **Isso (Prawn) Vadai** – Vadai topped with prawns, giving it a seafood twist  
• **Parippu (Dhal) Vadai** – Made with yellow split peas, a savory, crispy fritter  
• A popular snack during festivals and at street food stalls  
• Crispy on the outside, soft on the inside, and usually served with chutney or sambar''',
    'Cutlet':
    '''Cutlet is a savory fried snack made from minced meat or vegetables, usually coated in breadcrumbs. It features:

• A crispy, golden-brown crust  
• Common fillings include minced chicken, beef, or vegetables  
• Often served with a tangy dipping sauce  
• A popular snack at street food stalls and parties  
• Crunchy on the outside, juicy on the inside''',
    'Drumstick':
    '''Drumstick (Murunga) is often deep-fried or spiced and roasted, especially in South Indian-style cooking. Highlights include:

• Long green pods rich in nutrients  
• Often sliced, seasoned, and deep-fried or sautéed  
• Known for its earthy flavor and health benefits  
• May be served alone or with chutneys  
• An uncommon yet flavorful street-side snack option''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food['name']!)),
      body: Column(
        children: [
          Image.asset(food['image']!, width: double.infinity, height: 250, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              foodDescriptions[food['name']]!,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TraditionalFoodMapScreen(foodName: food['name']!),
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

// Traditional Food Map Screen (reused for street food too)
class TraditionalFoodMapScreen extends StatelessWidget {
  final String foodName;

  const TraditionalFoodMapScreen({super.key, required this.foodName});

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
            Text('Map will be displayed here.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
