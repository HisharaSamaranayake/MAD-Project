import 'package:flutter/material.dart';
// Import the Nature & Wildlife page
// Import the FoodCategoryScreen
// Import the Cultural & Historical page

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> categories = const [
    {
      'title': 'NATURE & WILD LIFE',
      'image': 'assets/nature.png',
      'route': '/nature',
    },
    {
      'title': 'CULTURAL & HISTORICAL',
      'image': 'assets/culture.png',
      'route': '/culture',
    },
    {
      'title': 'COASTAL & BEACHES',
      'image': 'assets/beaches.png',
      'route': '/beach',
    },
    {
      'title': 'HILL COUNTRY & SCENIC',
      'image': 'assets/hillcountry.jpg',
      'route': '/hillcountry',
    },
  ];

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/logo.png', height: 70)],
        ),
        leading: Builder(
          builder:
              (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            iconSize: 36, // <-- Make the icon larger here (default is 24)
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
              decoration: BoxDecoration(color: Colors.blue.shade200),
              child: Column(
                children: [Image.asset('assets/logo.png', height: 135)],
              ),
            ),
            _buildDrawerItem(
              Icons.home,
              'Explore SL',
                  () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              Icons.info,
              'Seasonal Experience',
                  () => Navigator.pushNamed(context, '/season'),
            ),
            _buildDrawerItem(
              Icons.settings,
              'Made in SL',
                  () => Navigator.pushNamed(context, '/madeinsl'),
            ),

            _buildDrawerItem(
              Icons.note_add,
              'Travel Note',
                  () => Navigator.pushNamed(context, '/travelnote'),
            ),
            _buildDrawerItem(
              Icons.restaurant,
              'Foods',
                  () => Navigator.pushNamed(context, '/food'),
            ),
            _buildDrawerItem(
              Icons.contacts,
              'Emergency Contacts',
                  () => Navigator.pushNamed(context, '/emergency'),
            ),
            _buildDrawerItem(
              Icons.contact_mail,
              'Cultural Norms And Safety',
                  () => Navigator.pushNamed(context, '/cultural_safety'),
            ),
            _buildDrawerItem(
              Icons.currency_exchange,
              'currency_exchange',
                  () => Navigator.pushNamed(context, '/currency_exchange'),
            ),
            _buildDrawerItem(
              Icons.person,
              'Profile',
                  () => Navigator.pushNamed(context, '/profile'),
            ),
            _buildDrawerItem(
              Icons.settings,
              'Settings',
                  () => Navigator.pushNamed(context, '/setting'),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFE1F1ED),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Explore SL',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.67,
                ),
                itemCount: categories.length,
                shrinkWrap: true, // To prevent unnecessary overflow
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
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set to 0 if this is the home screen
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/emergency');
              break;
            case 1:
              Navigator.pushNamed(context, '/travelnote');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Emergency'),
          BottomNavigationBarItem(icon: Icon(Icons.heart_broken), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Helper method to build ListTile for Drawer
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}
