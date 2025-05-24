import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'travel_note.dart';
import 'yala_map_screen.dart'; // Import your map screen here

class NatureWildlifePage extends StatelessWidget {
  const NatureWildlifePage({super.key});

  static const List<Map<String, String>> parks = [
    {
      'title': 'Yala National Park',
      'image': 'assets/Yala.jpg',
      'description':
          'Yala National Park is famous for its diverse wildlife, including leopards, elephants, and crocodiles.',
      'location': '6.5186,81.541',
    },
    {
      'title': 'Kumana National Park',
      'image': 'assets/kumana.jpg',
      'description':
          'Kumana National Park is known for its rich birdlife and elephants.',
      'location': '6.3958,81.4181',
    },
    {
      'title': 'Horton Plains National Park',
      'image': 'assets/horton.jpg',
      'description':
          'Horton Plains is a highland plateau offering breathtaking views.',
      'location': '6.9564,80.799',
    },
    {
      'title': 'Wilpattu National Park',
      'image': 'assets/wilpattu.jpg',
      'description':
          'Wilpattu is Sri Lanka’s largest national park with untouched wilderness.',
      'location': '8.4582,80.0518',
    },
  ];

  Future<Map<String, dynamic>> fetchWeather(String location) async {
    final apiKey = '9f2f8683ec9121922d9117236593e66a';
    final parts = location.split(',');
    final lat = parts[0];
    final lon = parts[1];
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('National Parks'),
        backgroundColor: Colors.lightBlue.shade50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: parks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () async {
                final weatherData = await fetchWeather(
                  parks[index]['location']!,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ParkDetailPage(
                      park: parks[index],
                      weather: weatherData,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    parks[index]['image']!,
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      parks[index]['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ParkDetailPage extends StatefulWidget {
  final Map<String, String> park;
  final Map<String, dynamic> weather;

  const ParkDetailPage({super.key, required this.park, required this.weather});

  @override
  State<ParkDetailPage> createState() => _ParkDetailPageState();
}

class _ParkDetailPageState extends State<ParkDetailPage> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
  }

  void _checkIfLiked() async {
    final liked = await TravelNotePage.isParkLiked(widget.park['title']!);
    if (mounted) {
      setState(() {
        isLiked = liked;
      });
    }
  }

  void toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    if (isLiked) {
      await TravelNotePage.addLikedPark(
        widget.park['title']!,
        widget.weather['main']['temp'].toString(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to notepad')),
        );
      }
    } else {
      await TravelNotePage.removeLikedPark(widget.park['title']!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removed from notepad')),
        );
      }
    }
  }

  void openMapNavigation(String parkTitle) {
    if (parkTitle == 'Yala National Park') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YalaMapScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Map not available for this park')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final park = widget.park;
    final weather = widget.weather;
    final extendedDescription =
        '${park['description']!}\n\nThis national park offers a rich blend of scenic beauty and wildlife. Visitors can experience guided safaris, birdwatching, and nature photography. It is highly recommended to plan your trip during early mornings or late afternoons for the best sightings. Always follow park rules and respect the natural environment.';

    return Scaffold(
      appBar: AppBar(
        title: Text(park['title']!),
        actions: [
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : null,
            ),
            onPressed: toggleLike,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              park['image']!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,
            ),
            const SizedBox(height: 10),
            Text(
              park['title']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Weather: ${weather['weather'][0]['main']} - ${weather['main']['temp']}°C',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(extendedDescription, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 25),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.map),
                label: const Text('Open Map'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.lightGreen.shade100,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  openMapNavigation(park['title']!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

