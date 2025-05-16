import 'package:flutter/material.dart';

class CulturalSafetyPage extends StatelessWidget {
  const CulturalSafetyPage({super.key});

  Widget buildInfoCard({
    required String title,
    required List<String> points,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            ...points.map((point) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.blue, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5EBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD5EBFF),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Cultural Norms and Safty",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          buildInfoCard(
            title: 'Respect for Religion',
            points: [
              'Dress modestly when visiting temples (cover shoulders and knees).',
              'Remove shoes and hats before entering religious sites.',
              'Do not turn your back to Buddha statues when taking photos.',
              'Avoid touching or sitting on religious monuments.',
            ],
          ),
          buildInfoCard(
            title: 'Greetings & Etiquette',
            points: [
              'Use the “Ayubowan” gesture as a respectful greeting.',
              'Avoid public displays of affection.',
              'Do not touch monks or hand objects directly to them.',
            ],
          ),
          buildInfoCard(
            title: 'Dress Code & Behavior',
            points: [
              'Wear modest clothing in towns and public spaces.',
              'Swimwear should only be worn at the beach.',
              'Cover up when leaving the beach or entering restaurants.',
            ],
          ),
          buildInfoCard(
            title: 'Tourist Safety Tips',
            points: [
              'Use trusted taxi apps like PickMe or Uber.',
              'Be cautious with tuk-tuk fares — agree before the ride.',
              'Avoid isolated places after dark.',
              'Store valuables in hotel safes.',
            ],
          ),
        ],
      ),
    );
  }
}
