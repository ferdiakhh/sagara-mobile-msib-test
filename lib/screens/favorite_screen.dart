import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            final favorites = weatherProvider.favoritePlaces;

            if (favorites.isEmpty) {
              return const Center(
                child: Text(
                  'No favorite places added yet.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final place = favorites[index];
                return WeatherCard(
                  cityName: place.cityName,
                  temperature: place.temperature,
                  condition: place.description,
                  icon: place.icon,
                  humidity: place.humidity,
                  windSpeed: place.windSpeed,
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'For you',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: 1, // Highlight pada item kedua (Favorites)
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context); // Kembali ke Home Screen
          }
        },
      ),
    );
  }
}
