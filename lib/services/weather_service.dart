import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart'; // Tambahkan import ini untuk geocoding
import '../models/weather.dart';

class WeatherService {
  final String apiKey = 'e6ea73dc65958de4ad22a4228f672c4b';

  Future<Weather> getWeather(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    print(response.body); // Debug: Melihat respons dari API

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Weather> getWeatherByCityName(String cityName) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data for $cityName');
    }
  }

  Future<List<WeatherForecast>> getForecast(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<WeatherForecast> forecasts = [];
      
      // Mengambil prakiraan setiap 24 jam untuk 3 hari ke depan
      for (int i = 0; i < data['list'].length; i += 8) {
        final forecastData = data['list'][i];
        final weather = WeatherForecast.fromJson(forecastData);
        forecasts.add(weather);
        if (forecasts.length == 3) break;
      }
      return forecasts;
    } else {
      throw Exception('Failed to load forecast data');
    }
  }

  // Metode untuk mendapatkan koordinat berdasarkan nama kota
  Future<List<Location>> getCoordinatesFromCityName(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        return locations;
      } else {
        throw Exception('No locations found for $cityName');
      }
    } catch (e) {
      print('Error in geocoding: $e');
      throw Exception('Failed to get coordinates');
    }
  }
}

class WeatherForecast {
  final String day;
  final double temperature;
  final String icon;

  WeatherForecast({
    required this.day,
    required this.temperature,
    required this.icon,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      day: DateTime.parse(json['dt_txt']).toLocal().weekday.toString(), // Konversi hari
      temperature: json['main']['temp'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
