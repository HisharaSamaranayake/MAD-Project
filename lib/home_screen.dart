import 'package:flutter/material.dart';
//import 'nature_wildlife_page.dart'; // Import the Nature & Wildlife page
import 'FoodCategoryScreen.dart'; // Import the FoodCategoryScreen
//import 'notification_page.dart'; // Import the NotificationPage

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'NATURE & WILD LIFE', 'image': 'assets/nature.png', 'route': '/nature'},
    {'title': 'CULTURAL & HISTORICAL', 'image': 'assets/culture.png'},
    {'title': 'COASTAL & BEACHES', 'image': 'assets/beaches.png'},
    {'title': 'HILL COUNTRY & SCENIC', 'image': 'assets/hillcountry.jpg'},
    {'title': 'FOOD', 'image': 'assets/foods.png', 'route': '/food'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 70),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Navigate to the Notification Page when the icon is pressed
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );*/
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
              ),
              child: Column(
                children: [
                  Image.asset('assets/logo.png', height: 135),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Explore SL'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Seasonal Experience'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Cultural Norms And Safety'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.note_add),
              title: Text('Travel Note'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/travelnote');

              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_sharp),
              title: Text('Foods'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                Navigator.pushNamed(context, '/food'); // Navigate to FoodCategoryScreen
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_sharp),
              title: Text('Emergency Contacts'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                Navigator.pushNamed(context, '/emergency'); // Navigate to FoodCategoryScreen
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_sharp),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                Navigator.pushNamed(context, '/profile'); // Navigate to FoodCategoryScreen
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_sharp),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                Navigator.pushNamed(context, '/setting'); // Navigate to FoodCategoryScreen
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFE1F1ED),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Explore SL',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.67,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (categories[index]['route'] == '/nature') {
                          Navigator.pushNamed(context, '/nature');
                        }
                        // Add other category routes as needed
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                image: DecorationImage(
                                  image: AssetImage(categories[index]['image']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                categories[index]['title']!,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
