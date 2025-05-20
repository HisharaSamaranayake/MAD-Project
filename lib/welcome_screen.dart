import 'package:flutter/material.dart';
import 'home_screen.dart'; // Update the path as needed

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/welcome_image.png',
              fit: BoxFit.cover,
            ),
          ),

          // Overlay content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Greeting at the top
                Column(
                  children: [
                    Text(
                      'Ayubowan! 👋',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(blurRadius: 4, color: Colors.black, offset: Offset(1, 1)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Explore the island!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        shadows: [
                          Shadow(blurRadius: 4, color: Colors.black, offset: Offset(1, 1)),
                        ],
                      ),
                    ),
                  ],
                ),

                Spacer(), // Push button + footer down

                // Get Started Button close to bottom
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[700],
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Footer text at the very bottom
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    '🇱🇰 Powered by Locals | Designed for Wanderers',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      shadows: [
                        Shadow(blurRadius: 4, color: Colors.black, offset: Offset(1, 1)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


