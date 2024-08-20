import 'dart:convert';
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? currentWeather;
  List<WeatherForecast> forecast = [];
  List<Weather> favoritePlaces = [];
  List<Weather> worldCitiesWeather = [];

  final WeatherService weatherService = WeatherService();

  WeatherProvider() {
    _loadFavorites();  
  }

  Future<void> fetchCurrentWeather( context, double lat, double lon) async {
    try {
      currentWeather = await weatherService.getWeather(lat, lon);
      print(currentWeather?.cityName);  // Debug untuk melihat apakah data berhasil diambil
      forecast = await weatherService.getForecast(lat, lon);
      notifyListeners();
    } catch (error) {
      if (error is SocketException) {
        _showNoInternetDialog(context);
      } else {
        print(error);  // Debug untuk menangkap dan menampilkan error lain
      }
    }
  }

  Future<void> fetchWorldCitiesWeather( context, List<String> cityNames) async {
    worldCitiesWeather.clear(); // Kosongkan daftar kota-kota besar
    for (String city in cityNames) {
      try {
        final weather = await weatherService.getWeatherByCityName(city);
        worldCitiesWeather.add(weather);
      } catch (error) {
        if (error is SocketException) {
          _showNoInternetDialog(context);
          break;
        } else {
          print('Error fetching weather data for $city: $error');
        }
      }
    }
    notifyListeners();
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void addFavoritePlace(Weather place) {
    if (!favoritePlaces.any((element) => element.cityName == place.cityName)) {
      favoritePlaces.add(place);
      _saveFavorites();  // Simpan favorit setelah menambahkannya
      notifyListeners();
    }
  }

  void removeFavoritePlace(String cityName) {
    favoritePlaces.removeWhere((place) => place.cityName == cityName);
    _saveFavorites();  // Simpan favorit setelah menghapusnya
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePlacesJson = favoritePlaces.map((weather) => json.encode(weather.toJson())).toList();
    await prefs.setStringList('favorite_places', favoritePlacesJson);
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoritePlacesJson = prefs.getStringList('favorite_places');
    if (favoritePlacesJson != null) {
      favoritePlaces = favoritePlacesJson.map((jsonString) => Weather.fromJson(json.decode(jsonString))).toList();
    }
    notifyListeners();
  }
}
