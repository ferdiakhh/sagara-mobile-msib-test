import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';
import '../providers/weather_provider.dart';

class DetailScreen extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final String icon;
  final double latitude;
  final double longitude;

  const DetailScreen({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('EE, dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(  // Membungkus seluruh konten dengan SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informasi cuaca utama
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Flexible(  // Membuat label nama kota responsif
                  child: Text(
                    cityName,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,  // Menghindari overflow teks
                    maxLines: 2,  // Membatasi teks menjadi 1 baris
                  ),
                ),

                  Text(
                    currentDate,
                    style: const TextStyle(color: Color.fromARGB(179, 24, 24, 24), fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('$humidity% humidity'),
                      Text('${windSpeed.toStringAsFixed(1)} m/s wind'),
                    ],
                  ),
                  Column(
                    children: [
                      Transform.scale(
                        scale: 3.0, 
                        child: Image.network(
                          'https://openweathermap.org/img/w/$icon.png',
                          height: 60, 
                        ),
                      ),
                      Text(
                        condition,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 48, 48, 48),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Text(
                'Latitude: $latitude, Longitude: $longitude',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),

              // Prakiraan cuaca per jam (untuk 5-6 jam ke depan)
              const Text(
                'Hourly Forecast',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 135,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6, // Contoh: Prakiraan 6 jam ke depan
                  itemBuilder: (context, index) {
                    // Gunakan data asli dalam aplikasi nyata
                    return _buildHourlyForecastCard(
                      time: '${(index + 1) * 3}:00',
                      temperature: temperature - (index * 2), // Contoh
                      icon: icon, 
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Prakiraan cuaca 3 hari ke depan
              const Text(
                '3-Day Forecast',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: List.generate(3, (index) {
                  // Menghitung tanggal untuk 3 hari ke depan
                  final DateTime forecastDate = DateTime.now().add(Duration(days: index + 1));
                  final String formattedDate = DateFormat('EE, dd/MM/yyyy').format(forecastDate);

                  return _buildDailyForecastCard(
                    day: formattedDate, // Ganti dengan tanggal yang diformat
                    temperature: temperature - (index * 3), // Contoh
                    icon: icon, // Gunakan icon yang sama untuk contoh
                  );
                }),
              ),

              const SizedBox(height: 20), // Beri sedikit ruang di atas tombol
              
              // Tombol untuk menambahkan ke favorit
              ElevatedButton(
                onPressed: () {
                  final weather = Weather(
                    cityName: cityName,
                    temperature: temperature,
                    description: condition,
                    humidity: humidity,
                    windSpeed: windSpeed,
                    icon: icon,
                    latitude: latitude,
                    longitude: longitude,
                  );
                  Provider.of<WeatherProvider>(context, listen: false)
                      .addFavoritePlace(weather);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$cityName added to favorites!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.blue, 
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Add to Favorites'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk prakiraan per jam
  Widget _buildHourlyForecastCard({
    required String time,
    required double temperature,
    required String icon,
  }) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.withOpacity(0.1),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Transform.scale(
            scale: 2.0, 
            child: Image.network(
              'https://openweathermap.org/img/w/$icon.png',
              height: 45, 
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${temperature.toStringAsFixed(1)}°C',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  // Widget untuk prakiraan 3 hari ke depan
  Widget _buildDailyForecastCard({
    required String day,
    required double temperature,
    required String icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day, 
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  '${temperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                Transform.scale(
                  scale: 1.8,
                  child: Image.network(
                    'https://openweathermap.org/img/w/$icon.png',
                    height: 30, 
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
