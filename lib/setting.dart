import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool vibrateEnabled = true;

  int _selectedIndex = 2; // Settings assumed to be index 2

  void resetSettings() {
    setState(() {
      notificationsEnabled = true;
      soundEnabled = true;
      vibrateEnabled = true;
    });
  }

  void saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings saved!')),
    );
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // Already on this tab
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/emergency');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/favorites');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/home');
    }
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget settingsRow(String title, String value, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value),
          Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget toggleRow(String title, bool value, Function(bool)? onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD5EBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFD5EBFF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'App Settings',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        children: [
          sectionTitle('System'),
          settingsRow('App Language', 'English'),

          Divider(),

          sectionTitle('Appearance'),
          settingsRow('Dark Mode', 'System Default'),
          settingsRow('Font', 'Default'),

          Divider(),

          sectionTitle('Accessibility'),
          settingsRow('Font Size', 'Medium'),
          settingsRow('Font Color', 'Default'),

          Divider(),

          sectionTitle('Alerts'),
          toggleRow('Allow Notifications', notificationsEnabled, (val) {
            setState(() {
              notificationsEnabled = val;
            });
          }),
          settingsRow('Notifications Style', 'Banner'),
          toggleRow('Sound', soundEnabled, (val) {
            setState(() {
              soundEnabled = val;
            });
          }),
          toggleRow('Vibrate', vibrateEnabled, (val) {
            setState(() {
              vibrateEnabled = val;
            });
          }),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: resetSettings,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(120, 45),
                  side: BorderSide(color: Colors.blue),
                ),
                child: Text('Reset'),
              ),
              ElevatedButton(
                onPressed: saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(120, 45),
                ),
                child: Text('Save'),
              ),
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.local_phone), label: 'Emergency'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        ],
      ),
    );
  }
}