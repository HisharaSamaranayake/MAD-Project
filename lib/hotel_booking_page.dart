import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelBookingPage extends StatelessWidget {
  const HotelBookingPage({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F7F2), // Light green background
      appBar: AppBar(
        title: const Text('Hotel Booking'),
        backgroundColor: const Color(0xFF317873),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Stay',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 6, 42, 33),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Curved edges
                  child: Image.asset(
                    'assets/stay.jpg',
                    width: 400, // Increased width
                    height: 200, // Increased height
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _launchURL('www.booking.com');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildImageLink('assets/hotel1.png', 'www.booking.com'),
              const SizedBox(height: 20),
              _buildImageLink('assets/hotel2.png', 'www.ResortSriLanka.com'),
              const SizedBox(height: 20),
              _buildImageLink('assets/hotel3.png', 'www.hotelsinsrilanka.lk'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageLink(String imagePath, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              url,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
