import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Event Detail Screen to display more information about the selected event
class EventDetailScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['event']),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(event['image']),
            SizedBox(height: 20),
            Text(
              event['event'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(event['description']),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (event.containsKey('latitude') && event.containsKey('longitude')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventMapScreen(
                        event: event,
                        latitude: event['latitude'],
                        longitude: event['longitude'],
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Location not available for this event')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blueAccent, width: 2),
              ),
              child: Text('View on Map'),
            ),
          ],
        ),
      ),
    );
  }
}

// Map Screen showing event location
class EventMapScreen extends StatefulWidget {
  final Map<String, dynamic> event;
  final double latitude;
  final double longitude;

  const EventMapScreen({
    super.key,
    required this.event,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<EventMapScreen> createState() => _EventMapScreenState();
}

class _EventMapScreenState extends State<EventMapScreen> {
  late GoogleMapController mapController;

  final double zoomLevel = 14.0;

  @override
  Widget build(BuildContext context) {
    final LatLng eventPosition = LatLng(widget.latitude, widget.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text('Map: ${widget.event['event']}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: eventPosition,
          zoom: zoomLevel,
        ),
        markers: {
          Marker(
            markerId: MarkerId('event_marker'),
            position: eventPosition,
            infoWindow: InfoWindow(title: widget.event['event']),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}

// Seasonal Experience Screen
class SeasonalExperienceScreen extends StatefulWidget {
  const SeasonalExperienceScreen({super.key});

  @override
  _SeasonalExperienceScreenState createState() =>
      _SeasonalExperienceScreenState();
}

class _SeasonalExperienceScreenState extends State<SeasonalExperienceScreen> {
  String? selectedMonth;

  final Map<String, List<Map<String, dynamic>>> seasonalEvents = {
    'January': [
      {
        'event': 'Duruthu Perahera – Kelaniya',
        'image': 'assets/duruthu_perahera.jpg',
        'description':
            'Duruthu Perahera is a grand Buddhist procession held every January in Kelaniya, near Colombo, to commemorate the first visit of the Buddha to Sri Lanka over 2,500 years ago. It marks the beginning of the Buddhist calendar year. The perahera is organized by the Kelaniya Raja Maha Viharaya, a sacred temple believed to be blessed by the Buddha himself. The event features a majestic parade with traditional dancers, drummers, whip-crackers, flag bearers, and beautifully adorned elephants. Devotees and tourists alike gather to witness this colorful and spiritual spectacle. Duruthu Perahera reflects the rich cultural and religious heritage of Sri Lanka, promoting peace and devotion.',
        'latitude': 7.0106,
        'longitude': 79.9761,
      },
      {
        'event': 'South Coast Beach Season',
        'image': 'assets/south_couste.jpg',
        'description':
            'Perfect beach weather in Mirissa, Unawatuna, and Hikkaduwa.',
        'latitude': 5.9486,
        'longitude': 80.4505,
      },
    ],
    'February': [
      {
        'event': 'Navam Perahera – Colombo',
        'image': 'assets/nawam_perahera.jpg',
        'description':
            'A major cultural parade with traditional dancers and elephants.',
        'latitude': 6.9271,
        'longitude': 79.8612,
      },
    ],
    'March': [
      {
        'event': 'Holi Festival – Northern Sri Lanka',
        'image': 'assets/holi.jpg',
        'description':
            'Celebrated by the Tamil community with colors, music, and dance.',
        'latitude': 9.6615,
        'longitude': 80.0255,
      },
      {
        'event': 'Whale Watching – Mirissa',
        'image': 'assets/whale_watching.jpg',
        'description':
            'Best time to see blue whales and dolphins in the south coast.',
        'latitude': 5.9486,
        'longitude': 80.4505,
      },
    ],
    'April': [
      {
        'event': 'Sinhala and Tamil New Year',
        'image': 'assets/new_year.jpg',
        'description':
            'Island-wide celebration with games, rituals, and traditional food.',
        'latitude': 7.8731,
        'longitude': 80.7718,
      },
    ],
    // ... (Other months with or without lat/lng)
  };

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> displayEvents =
        selectedMonth == null
            ? seasonalEvents
            : {selectedMonth!: seasonalEvents[selectedMonth!] ?? []};

    return Scaffold(
      appBar: AppBar(
        title: Text("Seasonal Experiences"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedMonth,
              hint: Text('Select a month', style: TextStyle(fontSize: 18)),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMonth = newValue;
                });
              },
              items: [
                DropdownMenuItem<String>(value: null, child: Text('Show All')),
                ...seasonalEvents.keys.map((month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: displayEvents.entries.expand((entry) {
                final month = entry.key;
                final events = entry.value;
                return [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: Text(
                      month,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  ...events.map(
                    (event) => Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            event['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(event['event']),
                        subtitle: Text(
                          event['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailScreen(event: event),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(),
                ];
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

