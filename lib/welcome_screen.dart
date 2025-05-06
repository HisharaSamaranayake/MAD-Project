 import 'dart:ui'; // For ImageFilter.blur
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Apply BackdropFilter for blurring the background image
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200.0, sigmaY: 100.0), // Adjust blur strength
            child: Opacity(
              opacity: 0.7, // Adjust opacity for the image
              child: Image.asset(
                "assets/bg3.jpg",
                fit: BoxFit.cover,
                width: double.infinity, // Makes sure the image covers the full width
                height: double.infinity, // Makes sure the image covers the full height
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png", height: 300),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 60), // width, height
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding to adjust button size
                ),
                child: Text("Register"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 60), // width, height
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding to adjust button size
                ),
                child: Text("Log In"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
