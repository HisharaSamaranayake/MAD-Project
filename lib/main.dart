import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

// Theme and Settings
import 'theme_provider.dart';

// Screens
import 'Splash_Screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'FoodCategoryScreen.dart';
import 'Emergency.dart';
import 'my_profile.dart';
import 'settings_screen.dart';
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
import 'travel_screen.dart';
import 'confirm_booking_screen.dart';
import 'route_screen.dart';
import 'hotel_booking_page.dart';
import 'yala_map_screen.dart';
import 'nearby_places_screen.dart';
import 'emergency_notifications_screen.dart';

// Firebase background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Debug print to verify current font family and size
    // print('Current fontFamily: ${themeProvider.fontFamily}, fontSize: ${themeProvider.fontSize}');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wander Lanka',
      locale: themeProvider.locale,
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light().copyWith(
        colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: Colors.teal,
        ),
        textTheme: ThemeData.light().textTheme.apply(
          fontFamily: themeProvider.fontFamily == 'Default' ? null : themeProvider.fontFamily,
          fontSizeFactor: themeProvider.fontSize / 16.0,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: themeProvider.fontFamily == 'Default' ? null : themeProvider.fontFamily,
          fontSizeFactor: themeProvider.fontSize / 16.0,
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/food': (context) => const FoodCategoryScreen(),
        '/profile': (context) => const MyProfilePage(),
        '/emergency': (context) => const EmergencyScreen(),
        '/setting': (context) => const SettingsScreen(),
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
        '/travel': (context) => TravelScreen(),
        '/stay': (context) => const HotelBookingPage(),
        '/yalamap': (context) => const YalaMapScreen(),
        '/emergency_notifications': (context) => const EmergencyNotificationScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/confirm_booking':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ConfirmBookingScreen(
                pickup: args['pickup'],
                destination: args['destination'],
                vehicleType: args['vehicleType'],
              ),
            );

          case '/route':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => RouteScreen(
                pickup: args['pickup'],
                destination: args['destination'],
                vehicleNo: args['vehicleNo'],
                driverPhone: args['driverPhone'],
              ),
            );

          case '/nearbyplaces':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => NearbyPlacesScreen(
                foodName: args['foodName'],
              ),
            );

          default:
            return null;
        }
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      ),
    );
  }
}


























