import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CulturalHistoricalPage extends StatelessWidget {
  final List<Map<String, String>> places = const [
    {
      'title': 'Sigiriya Rock Fortress',
      'image': 'assets/sigiriya.jpg',
      'description':
          'An ancient rock fortress and palace ruin known for its frescoes and gardens, Sigiriya is a UNESCO World Heritage Site and one of Sri Lanka’s most iconic landmarks.',
      'location': '7.957,80.7603',
    },
    {
      'title': 'Anuradhapura',
      'image': 'assets/anuradhapura.jpg',
      'description':
          'The sacred city of Anuradhapura is home to ancient Buddhist monuments, including stupas and monasteries, dating back to the 4th century BC.',
      'location': '8.3313,80.4037',
    },
    {
      'title': 'Polonnaruwa',
      'image': 'assets/polonnaruwa.jpg',
      'description':
          'Once the medieval capital, Polonnaruwa is filled with beautifully preserved ruins of palaces, shrines, and statues.',
      'location': '7.9403,81.0188',
    },
    {
      'title': 'Temple of the Tooth',
      'image': 'assets/kandy.jpg',
      'description':
          'Located in Kandy, this sacred temple houses the relic of the tooth of the Buddha and is an important pilgrimage site.',
      'location': '7.2936,80.6417',
    },
  ];

  const CulturalHistoricalPage({super.key}); // ✅ Constructor marked const

  Future<Map<String, dynamic>> fetchWeather(String location) async {
    final apiKey = '9f2f8683ec9121922d9117236593e66a';
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location.split(",")[0]}&lon=${location.split(",")[1]}&appid=$apiKey&units=metric',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to load weather data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cultural & Historical Places'),
        backgroundColor: Colors.orange.shade50,
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
                try {
                  final weather = await fetchWeather(
                    places[index]['location']!,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailPage(
                        place: places[index],
                        weather: weather,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error fetching weather: $e')),
                  );
                }
              },
              child: Column(
                children: [
                  Image.asset(
                    places[index]['image']!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      places[index]['title']!,
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
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Weather: ${weather['main']['temp']}°C, Humidity: ${weather['main']['humidity']}%, Wind: ${weather['wind']['speed']} km/h',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                Text(place['description']!,
                    style: const TextStyle(fontSize: 16)),
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
        child: Text('Map of $place', style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}


