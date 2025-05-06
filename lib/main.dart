import 'package:flutter/material.dart';

void main() {
  runApp(WanderLanka()); // Changed to match the class name
}

class WanderLanka extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wander Lanka',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg', // Ensure the image is in the assets folder
              fit: BoxFit.cover,
            ),
          ),
          // Login/Register Box
          Center(
            child: Container(
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.8,
                ), // Transparent white background
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome to Wander Lanka',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Register Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Register screen (implement this later)
                    },
                    child: Text('Register'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Login screen (implement this later)
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'nature_wildlife_page.dart';
import 'FoodCategoryScreen.dart';
import 'travelnote.dart';// Import FoodCategoryScreen
import 'Emergency.dart';
import 'my_profile.dart';
import 'setting.dart';


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
        '/nature': (context) => NatureWildlifePage(),
        '/home': (context) => HomeScreen(),
        '/food': (context) => FoodCategoryScreen(),
        '/travelnote': (context) => TravelNoteScreen(),
        '/profile': (context) => MyProfilePage(),
        '/emergency': (context) => EmergencyScreen(),
        '/setting': (context) => SettingsPage(),

// Ensure this route is here
      },
    );
  }
}
 */