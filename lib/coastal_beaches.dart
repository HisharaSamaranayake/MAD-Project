import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'travel_note.dart';  // Import TravelNotePage for persistence

class CoastalBeachesPage extends StatelessWidget {
  const CoastalBeachesPage({super.key});

  static const List<Map<String, String>> places = [
    {
      'title': 'Mirissa Beach',
      'image': 'assets/mirissa.jpg',
      'description':
      'Mirissa Beach is one of Sri Lanka’s most popular beach destinations, known for its pristine sandy shores and excellent whale watching opportunities.',
      'location': '5.9481,80.4500',
    },
    {
      'title': 'Unawatuna Beach',
      'image': 'assets/unawatuna.jpg',
      'description':
      'Unawatuna Beach is famous for its beautiful crescent-shaped beach, clear waters, and vibrant coral reefs, making it a great spot for swimming and diving.',
      'location': '5.9843,80.2180',
    },
    {
      'title': 'Bentota Beach',
      'image': 'assets/bentota.jpg',
      'description':
      'Bentota Beach offers a laid-back atmosphere with golden sands, crystal-clear waters, and plenty of water sports activities.',
      'location': '6.4139,79.9787',
    },
    {
      'title': 'Nilaveli Beach',
      'image': 'assets/nilaveli.jpg',
      'description':
      'Nilaveli Beach is known for its serene beauty, calm waters, and untouched natural surroundings, offering a perfect escape from the busy tourist hubs.',
      'location': '8.6002,81.1716',
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
        title: const Text('Coastal & Beaches'),
        backgroundColor: Colors.lightBlue.shade50,
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
          const SnackBar(content: Text('Added to favorites')),
        );
      }
    } else {
      await TravelNotePage.removeLikedPark(widget.place['title']!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removed from favorites')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;
    final weather = widget.weather;

    final extendedDescription = place['description']! +
        '\n\nThis beautiful beach offers a perfect blend of relaxation and adventure. Enjoy sunbathing, swimming, and exploring nearby local attractions. Always respect the natural environment and local customs.';

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
          ),
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
              'Weather: ${weather['weather'][0]['main']} - ${weather['main']['temp']}°C, Humidity: ${weather['main']['humidity']}%, Wind Speed: ${weather['wind']['speed']} m/s',
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
