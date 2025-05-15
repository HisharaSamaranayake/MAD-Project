import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
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

  TextStyle getDynamicTextStyle(double baseSize) {
    double scale;
    switch (selectedFontSize) {
      case 'Small':
        scale = 0.85;
        break;
      case 'Large':
        scale = 1.25;
        break;
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
      default:
        fontFamily = null;
    }

    return TextStyle(
      fontSize: baseSize * scale,
      fontFamily: fontFamily,
    );
  }

  Future<void> resetSettings() async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Reset'),
        content: const Text('Are you sure you want to reset all settings?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Reset')),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        notificationsEnabled = true;
        soundEnabled = true;
        vibrateEnabled = true;
        isDarkMode = false;
        selectedFont = 'Default';
        selectedFontSize = 'Medium';
      });
      await savePreferences();
    }
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0: Navigator.pushNamed(context, '/emergency'); break;
      case 1: Navigator.pushNamed(context, '/favorites'); break;
      case 2: Navigator.pushNamed(context, '/home'); break;
    }
  }

  void _showFontSelector() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Select Font"),
        children: fontOptions.map((font) {
          return RadioListTile(
            title: Text(font),
            value: font,
            groupValue: selectedFont,
            onChanged: (value) {
              setState(() => selectedFont = value.toString());
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  void _showFontSizeSelector() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Select Font Size"),
        children: fontSizeOptions.map((size) {
          return RadioListTile(
            title: Text(size),
            value: size,
            groupValue: selectedFontSize,
            onChanged: (value) {
              setState(() => selectedFontSize = value.toString());
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: getDynamicTextStyle(18).copyWith(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget toggleRow(String title, bool value, IconData icon, ValueChanged<bool>? onChanged, {String? description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          value: value,
          onChanged: (val) {
            setState(() {
              if (title == 'Dark Mode') isDarkMode = val;
              onChanged?.call(val);
            });
          },
          title: Text(title, style: getDynamicTextStyle(16).copyWith(fontWeight: FontWeight.w500)),
          secondary: Icon(icon, color: Colors.blueAccent),
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 56.0),
            child: Text(description, style: getDynamicTextStyle(13).copyWith(color: Colors.grey)),
          )
      ],
    );
  }

  Widget settingsRow(String title, String value, IconData icon, {VoidCallback? onTap, String? description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(title, style: getDynamicTextStyle(16).copyWith(fontWeight: FontWeight.w500)),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(value, style: getDynamicTextStyle(15)),
            const Icon(Icons.chevron_right)
          ]),
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
        ),
        body: ListView(
          children: [
            settingsSection('System', [
              settingsRow('App Language', 'English', Icons.language),
            ]),
            settingsSection('Appearance', [
              toggleRow('Dark Mode', isDarkMode, Icons.dark_mode, (val) => isDarkMode = val),
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
                  child: const Text('Reset', style: TextStyle(color: Colors.blue)),
                ),
                ElevatedButton(
                  onPressed: savePreferences,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
