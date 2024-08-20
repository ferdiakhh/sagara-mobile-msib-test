import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/detail_screen.dart';
import 'providers/weather_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Wise',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/favorites': (context) =>  const FavoriteScreen(),
        '/details': (context) => const DetailScreen(
          cityName: 'Jakarta',
          temperature: 20.0,
          condition: 'Thunder',
          humidity: 30,
          windSpeed: 4.0, icon: '',
          latitude: -6.2088,  
          longitude: 106.8456, 
        ),
      },
    );
  }
}
