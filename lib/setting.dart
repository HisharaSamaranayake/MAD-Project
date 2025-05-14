import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool vibrateEnabled = true;
  bool isDarkMode = false;

  String selectedFont = 'Default';
  String selectedFontSize = 'Medium';

  int _selectedIndex = 2;

  TextStyle getDynamicTextStyle(double baseSize) {
    double scale;
    switch (selectedFontSize) {
      case 'Small':
        scale = 0.85;
        break;
      case 'Large':
        scale = 1.25;
        break;
      case 'Medium':
      default:
        scale = 1.0;
    }

    String? fontFamily;
    switch (selectedFont) {
      case 'Serif':
        fontFamily = 'serif';
        break;
      case 'Monospace':
        fontFamily = 'monospace';
        break;
      case 'Default':
      default:
        fontFamily = null;
    }

    return TextStyle(
      fontSize: baseSize * scale,
      fontFamily: fontFamily,
    );
  }

  void resetSettings() async {
    bool confirmReset = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Reset'),
        content: const Text('Are you sure you want to reset all settings to default?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Reset')),
        ],
      ),
    );

    if (confirmReset) {
      setState(() {
        notificationsEnabled = true;
        soundEnabled = true;
        vibrateEnabled = true;
        isDarkMode = false;
        selectedFont = 'Default';
        selectedFontSize = 'Medium';
      });
    }
  }

  void saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
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

  void _showFontSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: ['Default', 'Serif', 'Monospace'].map((font) {
          return ListTile(
            title: Text(font),
            onTap: () {
              setState(() => selectedFont = font);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  void _showFontSizeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: ['Small', 'Medium', 'Large'].map((size) {
          return ListTile(
            title: Text(size),
            onTap: () {
              setState(() => selectedFontSize = size);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget settingsSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getDynamicTextStyle(18).copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget settingsRow(String title, String value, IconData icon, {String? description, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(title, style: getDynamicTextStyle(16).copyWith(fontWeight: FontWeight.w500)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: getDynamicTextStyle(15)),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: onTap,
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 56.0, bottom: 8.0),
            child: Text(description, style: getDynamicTextStyle(13).copyWith(color: Colors.grey)),
          ),
      ],
    );
  }

  Widget toggleRow(String title, bool value, IconData icon, Function(bool)? onChanged, {String? description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(title, style: getDynamicTextStyle(16).copyWith(fontWeight: FontWeight.w500)),
          secondary: Icon(icon, color: Colors.blueAccent),
          value: value,
          onChanged: (val) {
            setState(() {
              onChanged?.call(val);
              if (title == 'Dark Mode') isDarkMode = val;
            });
          },
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 56.0, bottom: 8.0),
            child: Text(description, style: getDynamicTextStyle(13).copyWith(color: Colors.grey)),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: const Color(0xFFD5EBFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFD5EBFF),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text('App Settings', style: getDynamicTextStyle(18).copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.notifications, color: Colors.black),
            ),
          ],
        ),
        body: ListView(
          children: [
            settingsSection('System', [
              settingsRow('App Language', 'English', Icons.language),
            ]),
            settingsSection('Appearance', [
              toggleRow('Dark Mode', isDarkMode, Icons.dark_mode, (val) => isDarkMode = val, description: 'Instantly changes the app theme'),
              settingsRow('Font', selectedFont, Icons.font_download, onTap: _showFontSelector),
            ]),
            settingsSection('Accessibility', [
              settingsRow('Font Size', selectedFontSize, Icons.text_fields, onTap: _showFontSizeSelector, description: 'Affects all text sizes in the app'),
            ]),
            settingsSection('Alerts', [
              toggleRow('Allow Notifications', notificationsEnabled, Icons.notifications, (val) => notificationsEnabled = val),
              toggleRow('Sound', soundEnabled, Icons.volume_up, (val) => soundEnabled = val),
              toggleRow('Vibrate', vibrateEnabled, Icons.vibration, (val) => vibrateEnabled = val),
            ]),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: resetSettings,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(130, 50),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    textStyle: getDynamicTextStyle(18).copyWith(fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Reset', style: TextStyle(color: Colors.blue)),
                ),
                ElevatedButton(
                  onPressed: saveSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(130, 50),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    textStyle: getDynamicTextStyle(18).copyWith(fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
      ),
    );
  }
}
