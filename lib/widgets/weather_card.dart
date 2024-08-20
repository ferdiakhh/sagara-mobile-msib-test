import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final int humidity;
  final double windSpeed;
  final VoidCallback? onTap;

  const WeatherCard({super.key, 
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cityName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        condition,
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                     Transform.scale(scale: 1.8, child:  Image.network(
                        'https://openweathermap.org/img/w/$icon.png',
                        height: 64,
                      ),
                      ),
                      Text('$humidity% humidity'),
                      Text('${windSpeed.toStringAsFixed(1)} m/s wind'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
