import 'package:flutter/material.dart';
import 'coastal_beaches.dart';
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
// Add the NatureWildlifePage import here
import 'nature_wildlife_page.dart'; 

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
      onGenerateRoute: (settings) {
        // Handle any dynamic routes or missing routes
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/welcome':
            return MaterialPageRoute(builder: (_) => const WelcomeScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/food':
            return MaterialPageRoute(builder: (_) => const FoodCategoryScreen());
          case '/profile':
            return MaterialPageRoute(builder: (_) => const MyProfilePage());
          case '/emergency':
            return MaterialPageRoute(builder: (_) => const EmergencyScreen());
          case '/setting':
            return MaterialPageRoute(builder: (_) => const SettingsPage());
          case '/beach':
            return MaterialPageRoute(builder: (_) => const CoastalBeachesPage());
          case '/culture':
            return MaterialPageRoute(builder: (_) => const CulturalHistoricalPage());
          case '/hillcountry':
            return MaterialPageRoute(builder: (_) => const HillCountryScenicPage());
          // Add the case for 'nature' route
          case '/nature':
            return MaterialPageRoute(builder: (_) => const NatureWildlifePage());
          default:
            // Handle unknown routes or show error page
            return MaterialPageRoute(builder: (_) => const SplashScreen()); // Default route
        }
      },
    );
  }
}
