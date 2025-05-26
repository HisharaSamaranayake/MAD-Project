import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Screens
import 'Splash_Screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'FoodCategoryScreen.dart';
import 'Emergency.dart';
import 'my_profile.dart';
import 'setting.dart';
import 'coastal_beaches.dart';
import 'cultural_historical_page.dart';
import 'hillcountry_scenic_page.dart';
import 'nature_wildlife_page.dart';
import 'map_screen.dart';
import 'made_in_sl_category.dart';
import 'seasonal_experience_page.dart';
import 'cultural_safety.dart';
import 'currency_exchange.dart';
import 'travel_note.dart';

// New screens for Travel and Stay
import 'travel_screen.dart';
import 'hotel_booking_page.dart';

// Import your new YalaMapScreen file
import 'yala_map_screen.dart';

// Import the NearbyPlacesScreen
import 'nearby_places_screen.dart';

// ✅ Import the Emergency Notification Screen
import 'emergency_notifications_screen.dart';

// Background handler for Firebase Messaging
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wander Lanka',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/splash',

      // Static routes
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/food': (context) => const FoodCategoryScreen(),
        '/profile': (context) => const MyProfilePage(),
        '/emergency': (context) => const EmergencyScreen(),
        '/setting': (context) => const SettingsPage(),
        '/beach': (context) => const CoastalBeachesPage(),
        '/culture': (context) => const CulturalHistoricalPage(),
        '/hillcountry': (context) => const HillCountryScenicPage(),
        '/nature': (context) => const NatureWildlifePage(),
        '/offlinemap': (context) => const MapScreen(),
        '/madeinsl': (context) => MadeInSriLankaScreen(),
        '/season': (context) => const SeasonalExperienceScreen(),
        '/travelnote': (context) => const TravelNotePage(),
        '/cultural_safety': (context) => const CulturalSafetyPage(),
        '/currency_exchange': (context) => const CurrencyExchangePage(),
        '/travel': (context) => const TravelScreen(),
        '/stay': (context) => const HotelBookingPage(),
        '/yalamap': (context) => const YalaMapScreen(),
        '/nearbyplaces': (context) => const NearbyPlacesScreen(foodName: ''),

        // ✅ Added missing emergency notifications route
        '/emergency_notifications': (context) => const EmergencyNotificationScreen(),
      },

      // Handle unknown routes
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      ),
    );
  }
}





















