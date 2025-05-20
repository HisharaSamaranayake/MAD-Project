import 'package:flutter/material.dart';

// Event Detail Screen to display more information about the selected event
class EventDetailScreen extends StatelessWidget {
  final Map<String, String> event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['event']!),
        backgroundColor: Colors.lightBlue.shade50,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(event['image']!),
            SizedBox(height: 12),
            Text(
              event['event']!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(event['description']!, style: TextStyle(fontSize: 14)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(event: event),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blueAccent, width: 2),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              child: Text('View on Map', style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

// Map Screen to display event location
class MapScreen extends StatelessWidget {
  final Map<String, String> event;

  const MapScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Location'),
        backgroundColor: Colors.lightBlue.shade50,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      ),
      body: Center(
        child: Text(
          'Map for ${event['event']} will be shown here.',
          style: TextStyle(fontSize: 16),
        ),
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

  final Map<String, List<Map<String, String>>> seasonalEvents = {
    'January': [
      {
        'event': 'Duruthu Perahera – Kelaniya',
        'image': 'assets/duruthu_perahera.jpg',
        'description':
        'A grand religious procession marking Lord Buddha’s first visit to Sri Lanka.'
      },
      {
        'event': 'South Coast Beach Season',
        'image': 'assets/south_couste.jpg',
        'description': 'Perfect beach weather in Mirissa, Unawatuna, and Hikkaduwa.'
      },
    ],
    'February': [
      {
        'event': 'Navam Perahera – Colombo',
        'image': 'assets/nawam_perahera.jpg',
        'description': 'A major cultural parade with traditional dancers and elephants.'
      },
    ],
    'March': [
      {
        'event': 'Holi Festival – Northern Sri Lanka',
        'image': 'assets/holi.jpg',
        'description': 'Celebrated by the Tamil community with colors, music, and dance.'
      },
      {
        'event': 'Whale Watching – Mirissa',
        'image': 'assets/whale_watching.jpg',
        'description': 'Best time to see blue whales and dolphins in the south coast.'
      },
    ],
    'April': [
      {
        'event': 'Sinhala and Tamil New Year',
        'image': 'assets/new_year.jpg',
        'description': 'Island-wide celebration with games, rituals, and traditional food.'
      },
    ],
    'May': [
      {
        'event': 'Vesak Festival',
        'image': 'assets/vesak.jpg',
        'description': 'Streets and temples decorated with lanterns and lights celebrating Buddha’s life.'
      },
    ],
    'June': [
      {
        'event': 'Poson Festival – Anuradhapura',
        'image': 'assets/poson.jpg',
        'description': 'Celebrates the arrival of Buddhism in Sri Lanka.'
      },
    ],
    'July': [
      {
        'event': 'Kataragama Festival',
        'image': 'assets/katharagama.jpg',
        'description': 'Pilgrimage with fire walking and devotional rituals.'
      },
    ],
    'August': [
      {
        'event': 'Kandy Esala Perahera',
        'image': 'assets/esala.jpg',
        'description': 'Grand 10-day procession with elephants, dancers, and cultural displays.'
      },
      {
        'event': 'Nallur Festival – Jaffna',
        'image': 'assets/nallur.jpg',
        'description': 'One of the most important Hindu festivals in the North.'
      },
    ],
    'September': [
      {
        'event': 'Little Adam’s Peak Hiking – Ella',
        'image': 'assets/ella_peak.jpg',
        'description': 'Ideal weather for scenic treks in the hill country.'
      },
    ],
    'October': [
      {
        'event': 'Deepavali – Hindu Communities',
        'image': 'assets/deepavali.jpg',
        'description': 'The festival of lights celebrated in the North and East.'
      },
    ],
    'November': [
      {
        'event': 'Kalpitiya Dolphin Watching Season Begins',
        'image': 'assets/dolphin.jpg',
        'description': 'Popular marine activity in the northwestern coastal town.'
      },
      {
        'event': 'Rainy Season Retreats – Knuckles Range',
        'image': 'assets/knuckles.jpg',
        'description': 'Peaceful and misty mountain stays perfect for nature lovers.'
      },
    ],
    'December': [
      {
        'event': 'Christmas Celebrations – Colombo',
        'image': 'assets/cristmass.jpg',
        'description': 'City decorations, carol singing, and joyful festivals.'
      },
      {
        'event': 'Hill Country Season – Nuwara Eliya & Ella',
        'image': 'assets/hill.jpg',
        'description': 'Cool weather, tea plantations, and cozy holiday vibes.'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> displayEvents =
    selectedMonth == null
        ? seasonalEvents
        : {
      selectedMonth!: seasonalEvents[selectedMonth] ?? [],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Seasonal Experiences", style: TextStyle(fontSize: 18, color: Colors.black)),
        backgroundColor: Colors.lightBlue.shade50,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton<String>(
              value: selectedMonth,
              hint: Text('Select a month', style: TextStyle(fontSize: 14)),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMonth = newValue;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Show All', style: TextStyle(fontSize: 14)),
                ),
                ...seasonalEvents.keys.map((month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month, style: TextStyle(fontSize: 14)),
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                    child: Text(
                      month,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                  ),
                  ...events.map((event) => Card(
                    margin:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EventDetailScreen(event: event),
                          ),
                        );
                      },
                      child: Container(
                        height: 200,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                event['image']!,
                                width: 140,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                event['event']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  )),
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
