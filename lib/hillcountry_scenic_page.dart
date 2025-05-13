import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HillCountryScenicPage extends StatelessWidget {
  final List<Map<String, String>> places = const [
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

  const HillCountryScenicPage({super.key});

  Future<Map<String, dynamic>> fetchWeather(String location) async {
    final apiKey = '9f2f8683ec9121922d9117236593e66a'; // OpenWeatherMap API Key
    final latLon = location.split(',');
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${latLon[0]}&lon=${latLon[1]}&appid=$apiKey&units=metric',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Weather API error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
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
          final place = places[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () async {
                try {
                  final weather = await fetchWeather(place['location']!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlaceDetailPage(place: place, weather: weather),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: Column(
                children: [
                  Image.asset(
                    place['image']!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      place['title']!,
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

class PlaceDetailPage extends StatelessWidget {
  final Map<String, String> place;
  final Map<String, dynamic> weather;

  const PlaceDetailPage({
    super.key,
    required this.place,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final temperature = weather['main']['temp'];
    final humidity = weather['main']['humidity'];
    final windSpeed = weather['wind']['speed'];

    return Scaffold(
      appBar: AppBar(
        title: Text(place['title']!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            place['image']!,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  place['title']!,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Weather: $temperature°C, Humidity: $humidity%, Wind: $windSpeed km/h',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                Text(
                  place['description']!,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlaceMapPage(place: place['title']!),
                      ),
                    );
                  },
                  child: const Text('Open On Map'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceMapPage extends StatelessWidget {
  final String place;

  const PlaceMapPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text(
          'Map of $place',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}


