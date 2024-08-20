import 'package:flutter/material.dart';
import '../models/weather.dart';
import 'weather_card.dart';
import '../screens/detail_screen.dart';

class WorldCitiesWeatherList extends StatelessWidget {
  final List<Weather> worldCitiesWeather;

  const WorldCitiesWeatherList({
    super.key,
    required this.worldCitiesWeather,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: worldCitiesWeather.length,
      itemBuilder: (context, index) {
        final cityWeather = worldCitiesWeather[index];
        return WeatherCard(
          cityName: cityWeather.cityName,
          temperature: cityWeather.temperature,
          condition: cityWeather.description,
          icon: cityWeather.icon,
          humidity: cityWeather.humidity,
          windSpeed: cityWeather.windSpeed,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  cityName: cityWeather.cityName,
                  temperature: cityWeather.temperature,
                  condition: cityWeather.description,
                  humidity: cityWeather.humidity,
                  windSpeed: cityWeather.windSpeed,
                  icon: cityWeather.icon,
                  latitude: cityWeather.latitude,
                  longitude: cityWeather.longitude,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
