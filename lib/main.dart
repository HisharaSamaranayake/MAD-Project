import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Screens
import 'Splash_Screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'FoodCategoryScreen.dart';
import 'Emergency.dart';
import 'my_profile.dart';
import 'setting.dart';
import 'coastal_beaches.dart';
import 'cultural_historical_page.dart';
import 'hillcountry_scenic_page.dart';
import 'nature_wildlife_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
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

      // ✅ Set initial route to splash screen
      initialRoute: '/splash',

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/food': (context) => const FoodCategoryScreen(),
        '/profile': (context) => const MyProfilePage(),
        '/emergency': (context) => const EmergencyScreen(),
        '/setting': (context) => const SettingsPage(),
        '/beach': (context) => const CoastalBeachesPage(),
        '/culture': (context) => const CulturalHistoricalPage(),
        '/hillcountry': (context) => const HillCountryScenicPage(),
        '/nature': (context) => const NatureWildlifePage(),
      },
    );
  }
}






