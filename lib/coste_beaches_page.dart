import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CoastalBeachesPage extends StatelessWidget {
  final List<Map<String, String>> places = [
    {
      'title': 'Mirissa Beach',
      'image': 'assets/mirissa.jpg',
      'description': 'Mirissa Beach is one of Sri Lanka’s most popular beach destinations, known for its pristine sandy shores and excellent whale watching opportunities.',
      'location': '5.9481,80.4500'
    },
    {
      'title': 'Unawatuna Beach',
      'image': 'assets/unawatuna.jpg',
      'description': 'Unawatuna Beach is famous for its beautiful crescent-shaped beach, clear waters, and vibrant coral reefs, making it a great spot for swimming and diving.',
      'location': '5.9843,80.2180'
    },
    {
      'title': 'Bentota Beach',
      'image': 'assets/bentota.jpg',
      'description': 'Bentota Beach offers a laid-back atmosphere with golden sands, crystal-clear waters, and plenty of water sports activities.',
      'location': '6.4139,79.9787'
    },
    {
      'title': 'Nilaveli Beach',
      'image': 'assets/nilaveli.jpg',
      'description': 'Nilaveli Beach is known for its serene beauty, calm waters, and untouched natural surroundings, offering a perfect escape from the busy tourist hubs.',
      'location': '8.6002,81.1716'
    },
  ];

  Future<Map<String, dynamic>> fetchWeather(String location) async {
    final apiKey = '9f2f8683ec9121922d9117236593e66a'; // Your OpenWeatherMap API key
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${location.split(",")[0]}&lon=${location.split(",")[1]}&appid=$apiKey&units=metric');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coastal & Beaches'),
        backgroundColor: Colors.blue.shade50,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () async {
                try {
                  final weather = await fetchWeather(places[index]['location']!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailPage(place: places[index], weather: weather),
                    ),
                  );
                } catch (e) {
                  print('Error fetching weather: $e');
                }
              },
              child: Column(
                children: [
                  Image.asset(places[index]['image']!, height: 150, width: double.infinity, fit: BoxFit.cover),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(places[index]['title']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

  PlaceDetailPage({required this.place, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place['title']!),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Image.asset(place['image']!, width: double.infinity, height: 200, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(place['title']!, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Weather: ${weather['main']['temp']}°C, Humidity: ${weather['main']['humidity']}%, Wind: ${weather['wind']['speed']} km/h',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                SizedBox(height: 16),
                Text(place['description']!, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlaceMapPage(place: place['title']!)),
                    );
                  },
                  child: Text('Open On Map'),
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
  PlaceMapPage({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text('Map of $place', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}