import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'welcome_screen.dart'; // Import WelcomeScreen
import 'home_screen.dart';
import 'FoodCategoryScreen.dart';
import 'Emergency.dart';
import 'my_profile.dart';
import 'setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',  // SplashScreen is shown on app launch
      routes: {
        '/': (context) => SplashScreen(),  // Load SplashScreen first
        '/login': (context) => LoginScreen(),  // Login screen route
        '/register': (context) => RegisterScreen(),  // Register screen route
        '/welcome': (context) => WelcomeScreen(),  // Welcome screen route
        '/home': (context) => HomeScreen(),  // Home screen route after successful login
        '/food': (context) => FoodCategoryScreen(),
        '/profile': (context) => MyProfilePage(),
        '/emergency': (context) => EmergencyScreen(),
        '/setting': (context) => SettingsPage(),
      },
    );
  }
}

