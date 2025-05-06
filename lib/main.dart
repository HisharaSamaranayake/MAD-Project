import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
//import 'nature_wildlife_page.dart';
import 'FoodCategoryScreen.dart';
//import 'travelnote.dart';// Import FoodCategoryScreen
//import 'Emergency.dart';
//import 'my_profile.dart';
//import 'setting.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        //'/nature': (context) => NatureWildlifePage(),
        '/home': (context) => HomeScreen(),
        '/food': (context) => FoodCategoryScreen(),
       //'/travelnote': (context) => TravelNoteScreen(),
        //'/profile': (context) => MyProfilePage(),
        //'/emergency': (context) => EmergencyScreen(),
        //'/setting': (context) => SettingsPage(),

// Ensure this route is here
      },
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/category_page.dart';
import 'screens/places_page.dart';
import 'screens/place_detail_page.dart';


void main() {
  runApp(ExploreSLApp());
}

class ExploreSLApp extends StatelessWidget {
  const ExploreSLApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore SL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/category': (context) => CategoryPage(),
        '/places': (context) => PlacesPage(),
        '/placeDetail': (context) => PlaceDetailPage(),

      },
    );
  }
}

 */