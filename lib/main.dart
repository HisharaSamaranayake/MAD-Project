import 'package:flutter/material.dart';
import 'coste_beaches_page.dart';
import 'cultural_historical_page.dart';
import 'hillcountry_scenic_page.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'FoodCategoryScreen.dart';
//import 'travelnote.dart';
import 'Emergency.dart';
import 'my_profile.dart';
import 'setting.dart';

import 'nature_wildlife_page.dart';


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
        '/profile': (context) => MyProfilePage(),
        '/emergency': (context) => EmergencyScreen(),
        '/setting': (context) => SettingsPage(),
        '/nature': (context) => NatureWildlifePage(),
        '/beach': (context) => CoastalBeachesPage(),
        '/culture': (context) => CulturalHistoricalPage(),
        '/hillcountry': (context) => HillCountryScenicPage(),


// Ensure this route is here
      },
    );
  }
}
