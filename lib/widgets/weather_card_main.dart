import 'package:flutter/material.dart';
import 'package:weatherwise/services/weather_service.dart';
import 'package:intl/intl.dart';


class WeatherCardMain extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final int humidity;
  final double windSpeed;
  final double precipitation;
  final List<WeatherForecast> forecast;
  final VoidCallback onTap; 

  const WeatherCardMain({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.precipitation,
    required this.forecast,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return GestureDetector(
      onTap: onTap, 
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.purple, 
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Current location',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  currentDate,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              cityName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${temperature.toStringAsFixed(0)}°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Transform.scale(
                      scale: 2.5, 
                      child: Image.network(
                        'https://openweathermap.org/img/w/$icon.png',
                        height: 48, 
                      ),
                    ),
                    Text(
                      condition,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${humidity.toStringAsFixed(0)}% humidity',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  '${windSpeed.toStringAsFixed(1)} m/s wind',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                
              ],
            ),
            const SizedBox(height: 16),
            const Row(
                  children: [
                    Text(
                      'Next three days',
                      style: TextStyle(color: Colors.white54,fontSize: 18),
                    ),
                    SizedBox(width: 8), 
                    Expanded(
                      child: Divider(
                        color: Colors.grey, 
                        thickness: 1, 
                      ),
                    ),
                  ],
                ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: forecast.asMap().entries.map((entry) {
                int index = entry.key;
                WeatherForecast day = entry.value;
                return _buildForecastItem(day, index);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastItem(WeatherForecast forecast, int index) {
    final DateTime today = DateTime.now();
    final DateTime forecastDate = today.add(Duration(days: index + 1));
    final String formattedDate = DateFormat('dd/MM').format(forecastDate);

    return Column(
      children: [
        Transform.scale(
          scale: 2.0, 
          child: Image.network(
            'https://openweathermap.org/img/w/${forecast.icon}.png',
            height: 32, 
          ),
        ),
        const SizedBox(height: 4),
        Text(
          formattedDate,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          '${forecast.temperature.toInt()}°C',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
