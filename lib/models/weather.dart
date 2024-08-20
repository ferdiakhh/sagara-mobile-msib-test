class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final double windSpeed;
  final int humidity;
  final String icon;
  final double latitude;
  final double longitude;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.windSpeed,
    required this.humidity,
    required this.icon,
    required this.latitude,
    required this.longitude,
  });

  // Fungsi untuk mengonversi JSON menjadi objek Weather
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'].toDouble(),
      humidity: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
      latitude: json['coord']['lat'].toDouble(),  
      longitude: json['coord']['lon'].toDouble(), 
    );
  }

  // Fungsi untuk mengonversi objek Weather menjadi map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {
        'temp': temperature,
        'humidity': humidity,
      },
      'weather': [
        {
          'description': description,
          'icon': icon,
        }
      ],
      'wind': {
        'speed': windSpeed,
      },
      'coord': {
        'lat': latitude,
        'lon': longitude,
      },
    };
  }
}
