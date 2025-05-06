import 'package:flutter/material.dart';

class TeaCoffeeScreen extends StatelessWidget {
  final List<Map<String, String>> teaCoffeeItems = [
    {'name': 'Ceylon Tea', 'image': 'assets/ceylon_tea.jpg'},
    {'name': 'Coffee', 'image': 'assets/coffee.jpg'},
    {'name': 'Herbal Tea', 'image': 'assets/herbal_tea.jpg'},
    {'name': 'Iced Tea', 'image': 'assets/iced_tea.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tea & Coffee')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: teaCoffeeItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TeaCoffeeDetailScreen(teaCoffee: teaCoffeeItems[index]),
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
                          image: AssetImage(teaCoffeeItems[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      teaCoffeeItems[index]['name']!,
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

class TeaCoffeeDetailScreen extends StatelessWidget {
  final Map<String, String> teaCoffee;

  TeaCoffeeDetailScreen({required this.teaCoffee});

  final Map<String, String> teaCoffeeDescriptions = {
    'Ceylon Tea':
    '''Ceylon Tea is world-famous for its rich flavor. It originates from Sri Lanka and is known for:

• Its strong aroma  
• Refreshing taste  
• Often enjoyed with milk or lemon  
• Consumed both hot and iced''',
    'Coffee':
    '''Coffee is a globally popular beverage made from roasted coffee beans. It can be served:

• Hot or iced  
• With milk or black  
• Often sweetened with sugar or syrups  
• Types include espresso, cappuccino, and latte''',
    'Herbal Tea':
    '''Herbal tea is a caffeine-free drink made from:

• Various herbs like chamomile, peppermint, or ginger  
• Often consumed for its calming effects  
• Can be enjoyed hot or cold  
• Known for its medicinal benefits such as aiding digestion''',
    'Iced Tea':
    '''Iced tea is a refreshing drink made from chilled tea, typically flavored with:

• Lemon, mint, or fruits  
• Sweetened with sugar or honey  
• Often served during warm weather  
• A popular alternative to sugary sodas''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(teaCoffee['name']!)),
      body: Column(
        children: [
          Image.asset(
            teaCoffee['image']!,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              teaCoffeeDescriptions[teaCoffee['name']]!,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TeaCoffeeMapScreen(drinkName: teaCoffee['name']!),
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

class TeaCoffeeMapScreen extends StatelessWidget {
  final String drinkName;

  TeaCoffeeMapScreen({required this.drinkName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Places for $drinkName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_cafe, size: 100, color: Colors.brown),
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
