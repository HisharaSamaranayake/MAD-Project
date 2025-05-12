import 'package:flutter/material.dart';
import 'nature_wildlife_page.dart'; // Import the Nature & Wildlife page
import 'FoodCategoryScreen.dart'; // Import the FoodCategoryScreen
import 'cultural_historical_page.dart'; // Import the Cultural & Historical page
//import 'notification_page.dart'; // Import the NotificationPage
import 'coste_beaches_page.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'NATURE & WILD LIFE', 'image': 'assets/nature.png', 'route': '/nature'},
    {'title': 'CULTURAL & HISTORICAL', 'image': 'assets/culture.png', 'route': '/culture'},
    {'title': 'COASTAL & BEACHES', 'image': 'assets/beaches.png','route': '/beach'},
    {'title': 'HILL COUNTRY & SCENIC', 'image': 'assets/hillcountry.jpg','route': '/hillcountry'},

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
        /*actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
        ],*/
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
                Navigator.pushNamed(context, '/season');
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
                Navigator.pop(context);
                Navigator.pushNamed(context, '/food');
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_sharp),
              title: Text('Emergency Contacts'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/emergency');
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_sharp),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_sharp),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/setting');
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
                        final route = categories[index]['route'];
                        if (route != null) {
                          Navigator.pushNamed(context, route);
                        }
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
