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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(event['image']!),
            Text(
              event['event']!,
            ),
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
      ),
      body: Center(
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
      },
      {
        'event': 'South Coast Beach Season',
        'image': 'assets/south_couste.jpg',
      },
    ],
    'February': [
      {
        'event': 'Navam Perahera – Colombo',
        'image': 'assets/nawam_perahera.jpg',
      },
    ],
    'March': [
      {
        'event': 'Holi Festival – Northern Sri Lanka',
        'image': 'assets/holi.jpg',
      },
      {
        'event': 'Whale Watching – Mirissa',
        'image': 'assets/whale_watching.jpg',
      },
    ],
    'April': [
      {
        'event': 'Sinhala and Tamil New Year',
        'image': 'assets/new_year.jpg',
      },
    ],
    'May': [
      {
        'event': 'Vesak Festival',
        'image': 'assets/vesak.jpg',
      },
    ],
    'June': [
      {
        'image': 'assets/poson.jpg',
      },
    ],
    'July': [
      {
        'event': 'Kataragama Festival',
        'image': 'assets/katharagama.jpg',
      },
    ],
    'August': [
      {
        'event': 'Kandy Esala Perahera',
        'image': 'assets/esala.jpg',
      },
      {
        'image': 'assets/nallur.jpg',
      },
    ],
    'September': [
      {
        'image': 'assets/ella_peak.jpg',
      },
    ],
    'October': [
      {
        'image': 'assets/deepavali.jpg',
      },
    ],
    'November': [
      {
        'event': 'Kalpitiya Dolphin Watching Season Begins',
        'image': 'assets/dolphin.jpg',
      },
      {
        'image': 'assets/knuckles.jpg',
      },
    ],
    'December': [
      {
        'image': 'assets/cristmass.jpg',
      },
      {
        'image': 'assets/hill.jpg',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> displayEvents =
    selectedMonth == null
        ? seasonalEvents

    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          Padding(
            child: DropdownButton<String>(
              value: selectedMonth,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMonth = newValue;
                });
              },
              items: [
                ...seasonalEvents.keys.map((month) {
                  return DropdownMenuItem<String>(
                    value: month,
                  );
                }).toList(),
              ],
            ),
          ),
          Expanded(
            child: ListView(
                final month = entry.key;
                final events = entry.value;
                return [
                  Padding(
                    child: Text(
                      month,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                    ),
                  ),
                    shape: RoundedRectangleBorder(
                    ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
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
