import 'package:flutter/material.dart';
import 'coste_beaches_page.dart';
import 'cultural_historical_page.dart';
import 'hillcountry_scenic_page.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'Splash_Screen.dart';
import 'home_screen.dart';
import 'FoodCategoryScreen.dart';
import 'Emergency.dart';
import 'my_profile.dart';
import 'setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wander Lanka',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/splash', // Start with SplashScreen
      routes: {
        '/splash': (context) => SplashScreen(),
        '/':
            (context) =>
                const LoginScreen(), // Start with LoginScreen after splash
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/welcome':
            (context) =>
                const WelcomeScreen(), // After login, go to WelcomeScreen
        '/home': (context) => HomeScreen(),
        '/food': (context) => const FoodCategoryScreen(),
        '/profile': (context) => const MyProfilePage(),
        '/emergency': (context) => const EmergencyScreen(),
        '/setting': (context) => const SettingsPage(),
        '/beach': (context) => CoastalBeachesPage(),
        '/culture': (context) => CulturalHistoricalPage(),
        '/hillcountry': (context) => HillCountryScenicPage(),

        // Ensure this route is here
      },
    );
  }
}
