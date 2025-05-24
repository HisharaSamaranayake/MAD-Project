import 'package:flutter/material.dart';

class EmergencyNotificationScreen extends StatelessWidget {
  final List<String> notifications;

  const EmergencyNotificationScreen({super.key, this.notifications = const []});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Alerts"),
      ),
      body: notifications.isEmpty
          ? Center(child: Text("No emergency alerts"))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.warning, color: Colors.red),
                  title: Text(notifications[index]),
                );
              },
            ),
    );
  }
}
