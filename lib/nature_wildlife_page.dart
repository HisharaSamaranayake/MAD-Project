import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'travelnote.dart';

class NatureWildlifePage extends StatelessWidget {
  final List<Map<String, String>> parks = [
    {
      'title': 'Yala National Park',
      'image': 'assets/Yala.jpg',
      'description': 'Yala National Park is famous for its diverse wildlife, including leopards, elephants, and crocodiles. It has a mix of dry forests, grasslands, and lagoons, making it a must-visit for nature lovers.',
      'location': '6.5186,81.541' // Latitude and Longitude for Yala
    },
    {
      'title': 'Kumana National Park',
      'image': 'assets/kumana.jpg',
      'description': 'Kumana National Park is known for its rich birdlife, particularly the migratory birds that visit the Kumana Bird Sanctuary. It also houses elephants, deer, and other wildlife species.',
      'location': '6.3958,81.4181' // Latitude and Longitude for Kumana
    },
    {
      'title': 'Horton Plains National Park',
      'image': 'assets/horton.jpg',
      'description': 'Horton Plains is a highland plateau offering breathtaking views, including the famous World’s End cliff. It is home to unique flora and fauna, including the Sri Lankan sambar deer.',
      'location': '6.9564,80.799' // Latitude and Longitude for Horton Plains
    },
    {
      'title': 'Wilpattu National Park',
      'image': 'assets/wilpattu.jpg',
      'description': 'Wilpattu is Sri Lanka’s largest national park, renowned for its "villus" (natural lakes), leopards, and untouched wilderness. It offers a secluded and immersive safari experience.',
      'location': '8.4582,80.0518' // Latitude and Longitude for Wilpattu
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
      print('Error: $e');
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('National Parks'),
        backgroundColor: Colors.lightBlue.shade50,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: parks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () async {
                try {
                  // Show loading indicator
                  final weatherData = await fetchWeather(parks[index]['location']!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParkDetailPage(park: parks[index], weather: weatherData),
                    ),
                  );
                } catch (e) {
                  print('Error fetching weather: $e');
                  // Optionally show an error message to the user
                }
              },
              child: Column(
                children: [
                  Image.asset(parks[index]['image']!, fit: BoxFit.cover, height: 150, width: double.infinity),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(parks[index]['title']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

class ParkDetailPage extends StatelessWidget {
  final Map<String, String> park;
  final Map<String, dynamic> weather;

  ParkDetailPage({required this.park, required this.weather});

  // This method simulates adding a place to the travel note


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(park['title']!),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Image.asset(park['image']!, fit: BoxFit.cover, width: double.infinity, height: 200),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(park['title']!, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                // Weather info
                Text('Weather: ${weather['main']['temp']}°C, Humidity: ${weather['main']['humidity']}%, Wind: ${weather['wind']['speed']} km/h',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                SizedBox(height: 16),
                Text(park['description']!, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ParkMapPage(park: park['title']!)),
                    );
                  },
                  child: Text('Open On Map'),
                ),
                SizedBox(height: 16),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ParkMapPage extends StatelessWidget {
  final String park;
  ParkMapPage({required this.park});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(park),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                color: Colors.green[100],
                child: Center(child: Text('Map of $park', style: TextStyle(fontSize: 18)))),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset('assets/kirinda.jpg', height: 50),
                    Text('Kirinda Beach'),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/kataragama.jpg', height: 50),
                    Text('Kataragama'),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/thissamaharama.jpg', height: 50),
                    Text('Thissamaharama'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}