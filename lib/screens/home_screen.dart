import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherwise/services/location_service.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_card_main.dart';
import '../widgets/search_city_dialog.dart';
import '../widgets/world_cities_weather_list.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider.fetchWorldCitiesWeather(context, [
      'Mekkah',
      'Manchester',
      'Rio de Janeiro',
      'Munich',
      'Sydney'
    ]);
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    await LocationService.requestLocationPermission(context);
  }

  Future<void> _searchCity(String cityName) async {
    try {
      await LocationService.searchCity(context, cityName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to find city. Please try again.')),
      );
    }
  }

  Future<void> _refreshWeatherData() async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    if (weatherProvider.currentWeather != null) {
      await weatherProvider.fetchCurrentWeather(
        context, // Pass context for error handling
        weatherProvider.currentWeather!.latitude,
        weatherProvider.currentWeather!.longitude,
      );
    }
  }

  Future<void> _setToCurrentLocation() async {
    await LocationService.setToCurrentLocation(context);
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('WEATHER WISE',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22)),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _setToCurrentLocation,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SearchCityDialog(
                  searchController: _searchController,
                  onSearch: () async {
                    Navigator.of(context).pop();
                    await _searchCity(_searchController.text);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshWeatherData,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<WeatherProvider>(
            builder: (context, weatherProvider, child) {
              final weather = weatherProvider.currentWeather;
              final forecast = weatherProvider.forecast;

              if (weather == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WeatherCardMain(
                    cityName: weather.cityName,
                    temperature: weather.temperature,
                    condition: weather.description,
                    icon: weather.icon,
                    humidity: weather.humidity,
                    windSpeed: weather.windSpeed,
                    precipitation: 0.0, // Contoh nilai, sesuaikan dengan data API
                    forecast: forecast,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            cityName: weather.cityName,
                            temperature: weather.temperature,
                            condition: weather.description,
                            humidity: weather.humidity,
                            windSpeed: weather.windSpeed,
                            icon: weather.icon,
                            latitude: weather.latitude,
                            longitude: weather.longitude,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        'Around the world',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8), // Memberi jarak antara label dan garis
                      Expanded(
                        child: Divider(
                          color: Colors.grey, // Warna garis
                          thickness: 1, // Ketebalan garis
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: WorldCitiesWeatherList(
                      worldCitiesWeather: weatherProvider.worldCitiesWeather,
                    ),
                  ),
                ],
              );
            },
          ),
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
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/favorites');
          }
        },
      ),
    );
  }
}
