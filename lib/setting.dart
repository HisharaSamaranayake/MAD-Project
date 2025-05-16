import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart'; // Your provider file

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    bool isDarkMode = settings.isDarkMode;

    return Scaffold(
      backgroundColor: const Color(0xFFD5EBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD5EBFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'App Settings',
          style: getDynamicTextStyle(context, 18).copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          settingsSection(context, 'System', [
            settingsRow(context, 'App Language', 'English', Icons.language),
          ]),
          settingsSection(context, 'Appearance', [
            toggleRow(
              context,
              'Dark Mode',
              isDarkMode,
              Icons.dark_mode,
                  (val) => settings.toggleDarkMode(val),
            ),
            settingsRow(
              context,
              'Font',
              settings.fontFamily,
              Icons.font_download,
              onTap: () => _showFontSelector(context),
            ),
          ]),
          settingsSection(context, 'Accessibility', [
            settingsRow(
              context,
              'Font Size',
              settings.fontSize,
              Icons.text_fields,
              onTap: () => _showFontSizeSelector(context),
              description: 'Affects all text sizes in the app',
            ),
          ]),
          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      settings.saveSettings();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings saved')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Save',
                      style: getDynamicTextStyle(context, 16)
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      settings.resetSettings();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings reset to default')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blueAccent),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Reset',
                      style: getDynamicTextStyle(context, 16)
                          .copyWith(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void _showFontSelector(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    final fontOptions = ['Default', 'Serif', 'Monospace'];

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Select Font"),
        children: fontOptions.map((font) {
          return RadioListTile(
            title: Text(font),
            value: font,
            groupValue: settings.fontFamily,
            onChanged: (value) {
              settings.setFontFamily(value.toString());
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  void _showFontSizeSelector(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    final fontSizeOptions = ['Small', 'Medium', 'Large'];

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Select Font Size"),
        children: fontSizeOptions.map((size) {
          return RadioListTile(
            title: Text(size),
            value: size,
            groupValue: settings.fontSize,
            onChanged: (value) {
              settings.setFontSize(value.toString());
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  TextStyle getDynamicTextStyle(BuildContext context, double baseSize) {
    final settings = Provider.of<SettingsProvider>(context);
    double scale;
    switch (settings.fontSize) {
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
    switch (settings.fontFamily) {
      case 'Serif':
        fontFamily = 'Merriweather'; // Make sure this font is added in pubspec.yaml if custom
        break;
      case 'Monospace':
        fontFamily = 'RobotoMono'; // Same for this
        break;
      default:
        fontFamily = null;
    }

    return TextStyle(
      fontSize: baseSize * scale,
      fontFamily: fontFamily,
    );
  }

  Widget settingsSection(
      BuildContext context, String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getDynamicTextStyle(context, 18).copyWith(
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

  Widget toggleRow(BuildContext context, String title, bool value,
      IconData icon, ValueChanged<bool>? onChanged,
      {String? description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          value: value,
          onChanged: onChanged,
          title: Text(
            title,
            style: getDynamicTextStyle(context, 16)
                .copyWith(fontWeight: FontWeight.w500),
          ),
          secondary: Icon(icon, color: Colors.blueAccent),
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 56.0),
            child: Text(
              description,
              style:
              getDynamicTextStyle(context, 13).copyWith(color: Colors.grey),
            ),
          )
      ],
    );
  }

  Widget settingsRow(BuildContext context, String title, String value,
      IconData icon,
      {VoidCallback? onTap, String? description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(
            title,
            style: getDynamicTextStyle(context, 16)
                .copyWith(fontWeight: FontWeight.w500),
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(value, style: getDynamicTextStyle(context, 15)),
            const Icon(Icons.chevron_right)
          ]),
          onTap: onTap,
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 56.0, bottom: 8.0),
            child: Text(
              description,
              style:
              getDynamicTextStyle(context, 13).copyWith(color: Colors.grey),
            ),
          ),
      ],
    );
  }
}
