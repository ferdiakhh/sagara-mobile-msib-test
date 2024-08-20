import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../services/weather_service.dart';

class LocationService {
  static Future<void> requestLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchCurrentWeather(context, position.latitude, position.longitude);
  }

  static Future<void> searchCity(BuildContext context, String cityName) async {
    final weatherService = WeatherService();
    try {
      List<Location> locations =
          await weatherService.getCoordinatesFromCityName(cityName);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        await Provider.of<WeatherProvider>(context, listen: false)
            .fetchCurrentWeather(context, location.latitude, location.longitude);
      }
    } catch (e) {
      print('Error searching city: $e');
      throw e;
    }
  }

  static Future<void> setToCurrentLocation(BuildContext context) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await Provider.of<WeatherProvider>(context, listen: false)
          .fetchCurrentWeather(context,position.latitude, position.longitude);
    } catch (e) {
      print('Error fetching current location: $e');
      throw e;
    }
  }
}
