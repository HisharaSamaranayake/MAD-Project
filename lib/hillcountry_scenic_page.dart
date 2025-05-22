import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'travel_note.dart';

class HillCountryScenicPage extends StatelessWidget {
  const HillCountryScenicPage({super.key});

  static const List<Map<String, String>> places = [
    {
      'title': 'Nuwara Eliya',
      'image': 'assets/nuwaraeliya.jpg',
      'description':
      'Known as "Little England," Nuwara Eliya is a cool, misty town surrounded by tea plantations, colonial architecture, and beautiful gardens.',
      'location': '6.9708,80.7829',
    },
    {
      'title': 'Ella',
      'image': 'assets/ella.jpg',
      'description':
      'Ella is a small town in the hill country with stunning views, lush greenery, and attractions like the Nine Arches Bridge and Ella Rock.',
      'location': '6.8731,81.0462',
    },
    {
      'title': 'Horton Plains',
      'image': 'assets/horton.jpg',
      'description':
      'A national park in the central highlands, Horton Plains is known for World’s End, Baker’s Falls, and diverse flora and fauna.',
      'location': '6.8098,80.7998',
    },
    {
      'title': 'Adam’s Peak',
      'image': 'assets/adamspeak.jpg',
      'description':
      'A sacred mountain peak with a footprint-shaped rock formation at the summit, revered by Buddhists, Hindus, and Muslims.',
      'location': '6.8096,80.4999',
    },
  ];

  Future<Map<String, dynamic>> fetchWeather(String location) async {
    final apiKey = '9f2f8683ec9121922d9117236593e66a';
    final parts = location.split(',');
    final lat = parts[0];
    final lon = parts[1];
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

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
        title: const Text('Hill Country & Scenic Places'),
        backgroundColor: Colors.green.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () async {
                final weatherData = await fetchWeather(places[index]['location']!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlaceDetailPage(
                      place: places[index],
                      weather: weatherData,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    places[index]['image']!,
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      places[index]['title']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

class PlaceDetailPage extends StatefulWidget {
  final Map<String, String> place;
  final Map<String, dynamic> weather;

  const PlaceDetailPage({
    super.key,
    required this.place,
    required this.weather,
  });

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
  }

  void _checkIfLiked() async {
    final liked = await TravelNotePage.isParkLiked(widget.place['title']!);
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
          widget.place['title']!, widget.weather['main']['temp'].toString());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to notepad')),
        );
      }
    } else {
      await TravelNotePage.removeLikedPark(widget.place['title']!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removed from notepad')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;
    final weather = widget.weather;

    final extendedDescription = place['description']! +
        '\n\nThis scenic place offers beautiful views, local culture, and great spots for photography and hiking. Be sure to check weather conditions before visiting and respect nature and local customs.';

    return Scaffold(
      appBar: AppBar(
        title: Text(place['title']!),
        actions: [
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : null,
            ),
            onPressed: toggleLike,
          )
        ],


      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              place['image']!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,
            ),
            const SizedBox(height: 10),
            Text(
              place['title']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Weather: ${weather['weather'][0]['main']} - ${weather['main']['temp']}°C',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              extendedDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Map feature coming soon!')),
                  );
                },
                icon: const Icon(Icons.map),
                label: const Text('View on Map'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
