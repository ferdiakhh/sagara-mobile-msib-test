import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final String day;
  final String icon;
  final int temp;

  const ForecastCard({
    super.key,
    required this.day,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(day, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Image.network(
              'https://openweathermap.org/img/w/$icon.png',
              height: 32,
            ),
            const SizedBox(height: 8),
            Text('$temp°C', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
