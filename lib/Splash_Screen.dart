import 'dart:ui'; // For ImageFilter.blur
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const Color darkPeacock = Color(0xFF014D4D); // Dark peacock blue

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Apply BackdropFilter for blurring the background image
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200.0, sigmaY: 100.0),
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                "assets/splashscreen.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png", height: 300),
              const SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 60),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  foregroundColor: darkPeacock, // Text color
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Bigger font
                ),
                child: const Text("Register"),
              ),

              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 60),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  foregroundColor: darkPeacock, // Text color
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Bigger font
                ),
                child: const Text("Log In"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



