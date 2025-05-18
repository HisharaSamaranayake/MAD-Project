import 'package:flutter/material.dart';

// Event Detail Screen to display more information about the selected event
class EventDetailScreen extends StatelessWidget {
  final Map<String, String> event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['event']!),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(event['image']!),
            SizedBox(height: 20),
            Text(
              event['event']!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(event['description']!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(event: event),
                  ),
                );
              },
              child: Text('View on Map'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blueAccent, width: 2),
              ),
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

  MapScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Location'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text('Map for ${event['event']} will be shown here.'),
      ),
    );
  }
}

// Seasonal Experience Screen
class SeasonalExperienceScreen extends StatefulWidget {
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
            'A grand religious procession marking Lord Buddha’s first visit to Sri Lanka.',
      },
      {
        'event': 'South Coast Beach Season',
        'image': 'assets/south_couste.jpg',
        'description':
            'Perfect beach weather in Mirissa, Unawatuna, and Hikkaduwa.',
      },
    ],
    'February': [
      {
        'event': 'Navam Perahera – Colombo',
        'image': 'assets/nawam_perahera.jpg',
        'description':
            'A major cultural parade with traditional dancers and elephants.',
      },
    ],
    'March': [
      {
        'event': 'Holi Festival – Northern Sri Lanka',
        'image': 'assets/holi.jpg',
        'description':
            'Celebrated by the Tamil community with colors, music, and dance.',
      },
      {
        'event': 'Whale Watching – Mirissa',
        'image': 'assets/whale_watching.jpg',
        'description':
            'Best time to see blue whales and dolphins in the south coast.',
      },
    ],
    'April': [
      {
        'event': 'Sinhala and Tamil New Year',
        'image': 'assets/new_year.jpg',
        'description':
            'Island-wide celebration with games, rituals, and traditional food.',
      },
    ],
    'May': [
      {
        'event': 'Vesak Festival',
        'image': 'assets/vesak.jpg',
        'description':
            'Streets and temples decorated with lanterns and lights celebrating Buddha’s life.',
      },
    ],
    'June': [
      {
        'event': 'Poson Festival  Anuradhapura',
        'image': 'assets/poson.jpg',
        'description': 'Celebrates the arrival of Buddhism in Sri Lanka.',
      },
    ],
    'July': [
      {
        'event': 'Kataragama Festival',
        'image': 'assets/katharagama.jpg',
        'description': 'Pilgrimage with fire walking and devotional rituals.',
      },
    ],
    'August': [
      {
        'event': 'Kandy Esala Perahera',
        'image': 'assets/esala.jpg',
        'description':
            'Grand 10-day procession with elephants, dancers, and cultural displays.',
      },
      {
        'event': 'Nallur Festival  Jaffna',
        'image': 'assets/nallur.jpg',
        'description':
            'One of the most important Hindu festivals in the North.',
      },
    ],
    'September': [
      {
        'event': 'Little Adam’s Peak Hiking  Ella',
        'image': 'assets/ella_peak.jpg',
        'description': 'Ideal weather for scenic treks in the hill country.',
      },
    ],
    'October': [
      {
        'event': 'Deepavali  Hindu Communities',
        'image': 'assets/deepavali.jpg',
        'description':
            'The festival of lights celebrated in the North and East.',
      },
    ],
    'November': [
      {
        'event': 'Kalpitiya Dolphin Watching Season Begins',
        'image': 'assets/dolphin.jpg',
        'description':
            'Popular marine activity in the northwestern coastal town.',
      },
      {
        'event': 'Rainy Season Retreats  Knuckles Range',
        'image': 'assets/knuckles.jpg',
        'description':
            'Peaceful and misty mountain stays perfect for nature lovers.',
      },
    ],
    'December': [
      {
        'event': 'Christmas Celebrations  Colombo',
        'image': 'assets/cristmass.jpg',
        'description': 'City decorations, carol singing, and joyful festivals.',
      },
      {
        'event': 'Hill Country Season  Nuwara Eliya & Ella',
        'image': 'assets/hill.jpg',
        'description': 'Cool weather, tea plantations, and cozy holiday vibes.',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> displayEvents =
        selectedMonth == null
            ? seasonalEvents
            : {selectedMonth!: seasonalEvents[selectedMonth] ?? []};

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
                }).toList(),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children:
                  displayEvents.entries.expand((entry) {
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
                                event['image']!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(event['event']!),
                            subtitle: Text(
                              event['description']!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
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
