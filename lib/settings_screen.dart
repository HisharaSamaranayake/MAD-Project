import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const Color peacockBlue = Color(0xFF006B7F);
  static const Color skyBlue = Color(0xFFE0F0F5);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Map fontSize double to string for dropdown
    String fontSizeValue() {
      if (themeProvider.fontSize <= 14.0) return 'Small';
      if (themeProvider.fontSize >= 18.0) return 'Large';
      return 'Medium';
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // dynamic background
      appBar: AppBar(
        title: const Text("App Settings"),
        backgroundColor: skyBlue, // Changed from peacockBlue to skyBlue
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          sectionTitle("System", peacockBlue),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text(
                "App Language",
                style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              trailing: DropdownButton<String>(
                dropdownColor: Theme.of(context).cardColor,
                value: themeProvider.locale.languageCode,
                items: const [
                  DropdownMenuItem(value: 'en', child: Text("English")),
                  DropdownMenuItem(value: 'si', child: Text("සිංහල")),
                  DropdownMenuItem(value: 'ta', child: Text("தமிழ்")),
                ],
                onChanged: (value) {
                  if (value != null) themeProvider.setLocale(value);
                },
                underline: Container(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          sectionTitle("Appearance", peacockBlue),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            color: Theme.of(context).cardColor,
            child: SwitchListTile(
              activeColor: peacockBlue,
              title: Text(
                "Dark Mode",
                style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleTheme(value),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text(
                "Font",
                style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              trailing: DropdownButton<String>(
                dropdownColor: Theme.of(context).cardColor,
                value: themeProvider.fontFamily,
                items: const [
                  DropdownMenuItem(value: 'Default', child: Text("Default")),
                  DropdownMenuItem(value: 'Roboto', child: Text("Roboto")),
                  DropdownMenuItem(value: 'Courier', child: Text("Courier")),
                ],
                onChanged: (value) {
                  if (value != null) themeProvider.setFontFamily(value);
                },
                underline: Container(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          sectionTitle("Accessibility", peacockBlue),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text(
                "Font Size",
                style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              trailing: DropdownButton<String>(
                dropdownColor: Theme.of(context).cardColor,
                value: fontSizeValue(),
                items: const [
                  DropdownMenuItem(value: 'Small', child: Text("Small")),
                  DropdownMenuItem(value: 'Medium', child: Text("Medium")),
                  DropdownMenuItem(value: 'Large', child: Text("Large")),
                ],
                onChanged: (value) {
                  if (value != null) {
                    double fontSize = value == 'Small'
                        ? 14.0
                        : value == 'Large'
                            ? 18.0
                            : 16.0; // Medium default
                    themeProvider.setFontSize(fontSize);
                  }
                },
                underline: Container(),
              ),
            ),
          ),

          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: peacockBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 5,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Settings saved.")),
                  );
                },
                child: const Text("Save"),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: peacockBlue, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  foregroundColor: peacockBlue,
                ),
                onPressed: () => themeProvider.resetSettings(),
                child: const Text("Reset"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget sectionTitle(String title, Color color) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: color,
          ),
        ),
      );
}










