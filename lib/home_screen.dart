import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
    listenToMessages();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("Firebase Messaging Token: $token");
  }

  void listenToMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message while app in foreground: ${message.messageId}');
      if (message.notification != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(message.notification?.title ?? 'Notification'),
            content: Text(message.notification?.body ?? ''),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/logo.png', height: 60)],
        ),
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            iconSize: 36,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              iconSize: 30,
              onPressed: () {
                Navigator.pushNamed(context, '/emergency_notifications'); 
              },
            ),
          ),
        ],
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
            _buildDrawerItem(Icons.home, 'Explore SL', () => Navigator.pop(context)),
            _buildDrawerItem(Icons.info, 'Seasonal Experience', () => Navigator.pushNamed(context, '/season')),
            _buildDrawerItem(Icons.contact_mail, 'Cultural Norms And Safety', () => Navigator.pushNamed(context, '/cultural_safety')),
            _buildDrawerItem(Icons.note_add, 'Travel Note', () => Navigator.pushNamed(context, '/travelnote')),
            _buildDrawerItem(Icons.airplanemode_active, 'Travel', () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/travel');
            }),
            _buildDrawerItem(Icons.hotel, 'Stay', () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/stay');
            }),
            _buildDrawerItem(Icons.restaurant, 'Foods', () => Navigator.pushNamed(context, '/food')),
            _buildDrawerItem(Icons.local_offer, 'Made in SL', () => Navigator.pushNamed(context, '/madeinsl')),
            _buildDrawerItem(Icons.contacts, 'Emergency Contacts', () => Navigator.pushNamed(context, '/emergency')),
            _buildDrawerItem(Icons.currency_exchange, 'Currency Exchange', () => Navigator.pushNamed(context, '/currency_exchange')),
            _buildDrawerItem(Icons.person, 'Profile', () => Navigator.pushNamed(context, '/profile')),
            _buildDrawerItem(Icons.settings, 'Settings', () => Navigator.pushNamed(context, '/setting')),
            _buildDrawerItem(Icons.map, 'Offline Map', () => Navigator.pushNamed(context, '/offlinemap')),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Explore SL',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}


















