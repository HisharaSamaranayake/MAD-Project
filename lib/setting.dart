
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final List<String> fontOptions = ['Default', 'Serif', 'Monospace'];
  final List<String> fontSizeOptions = ['Small', 'Medium', 'Large'];

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('notifications') ?? true;
      soundEnabled = prefs.getBool('sound') ?? true;
      vibrateEnabled = prefs.getBool('vibrate') ?? true;
      isDarkMode = prefs.getBool('darkMode') ?? false;
      selectedFont = prefs.getString('font') ?? 'Default';
      selectedFontSize = prefs.getString('fontSize') ?? 'Medium';
    });
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', notificationsEnabled);
    await prefs.setBool('sound', soundEnabled);
    await prefs.setBool('vibrate', vibrateEnabled);
    await prefs.setBool('darkMode', isDarkMode);
    await prefs.setString('font', selectedFont);
    await prefs.setString('fontSize', selectedFontSize);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }

  Future<void> resetSettings() async {
    final confirmReset = await showDialog<bool>(
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

    if (confirmReset == true) {
      setState(() {
        notificationsEnabled = true;
        soundEnabled = true;
        vibrateEnabled = true;
        isDarkMode = false;
        selectedFont = 'Default';
        selectedFontSize = 'Medium';
      });
      savePreferences();
    }
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
              style: const TextStyle(
                fontSize: 18,
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

  Widget settingsRow(String title, String value, IconData icon,
      {String? description, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: const TextStyle(fontSize: 15)),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: onTap,
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 56.0, bottom: 8.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
      ],
    );
  }

  Widget toggleRow(String title, bool value, IconData icon, Function(bool)? onChanged,
      {String? description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
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
            child: Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
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
          title: const Text(
            'App Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
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
              toggleRow('Dark Mode', isDarkMode, Icons.dark_mode, (val) => isDarkMode = val,
                  description: 'Instantly changes the app theme'),
              settingsRow('Font', selectedFont, Icons.font_download, onTap: () async {
                final font = await showDialog<String>(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text('Select Font'),
                    children: fontOptions.map((f) {
                      return SimpleDialogOption(
                        onPressed: () => Navigator.pop(context, f),
                        child: Text(f),
                      );
                    }).toList(),
                  ),
                );
                if (font != null) {
                  setState(() => selectedFont = font);
                }
              }),
            ]),
            settingsSection('Accessibility', [
              settingsRow('Font Size', selectedFontSize, Icons.text_fields, onTap: () async {
                final size = await showDialog<String>(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text('Select Font Size'),
                    children: fontSizeOptions.map((f) {
                      return SimpleDialogOption(
                        onPressed: () => Navigator.pop(context, f),
                        child: Text(f),
                      );
                    }).toList(),
                  ),
                );
                if (size != null) {
                  setState(() => selectedFontSize = size);
                }
              }, description: 'Affects all text sizes in the app'),
            ]),
            settingsSection('Alerts', [
              toggleRow('Allow Notifications', notificationsEnabled, Icons.notifications,
                  (val) => notificationsEnabled = val),
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
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Reset', style: TextStyle(color: Colors.blue)),
                ),
                ElevatedButton(
                  onPressed: savePreferences,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(130, 50),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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

