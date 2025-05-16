import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'settings_provider.dart';  // Adjust path as needed
import 'coastal_beaches.dart';
import 'cultural_historical_page.dart';
import 'hillcountry_scenic_page.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'Splash_Screen.dart';
import 'home_screen.dart';
import 'FoodCategoryScreen.dart';
import 'Emergency.dart';
import 'my_profile.dart';
import 'setting.dart';
import 'nature_wildlife_page.dart';
import 'cultural_safety.dart';
import 'currency_exchange.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider()..loadSettings(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    final textTheme = settings.getTextTheme(
      settings.isDarkMode ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wander Lanka',
      theme: settings.isDarkMode
          ? ThemeData.dark().copyWith(textTheme: textTheme)
          : ThemeData.light().copyWith(textTheme: textTheme),
      initialRoute: '/splash',
      onGenerateRoute: (settingsRoute) {
        switch (settingsRoute.name) {
          case '/splash':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/welcome':
            return MaterialPageRoute(builder: (_) => const WelcomeScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/food':
            return MaterialPageRoute(builder: (_) => const FoodCategoryScreen());
          case '/profile':
            return MaterialPageRoute(builder: (_) => const MyProfilePage());
          case '/emergency':
            return MaterialPageRoute(builder: (_) => const EmergencyScreen());
          case '/cultural_safety':
            return MaterialPageRoute(builder: (_) => const CulturalSafetyPage());
          case '/currency_exchange':
            return MaterialPageRoute(builder: (_) => const CurrencyExchangePage());
          case '/setting':
            return MaterialPageRoute(builder: (_) => const SettingsPage());
          case '/beach':
            return MaterialPageRoute(builder: (_) => const CoastalBeachesPage());
          case '/culture':
            return MaterialPageRoute(builder: (_) => const CulturalHistoricalPage());
          case '/hillcountry':
            return MaterialPageRoute(builder: (_) => const HillCountryScenicPage());
          case '/nature':
            return MaterialPageRoute(builder: (_) => const NatureWildlifePage());
          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
    );
  }
}
