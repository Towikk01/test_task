class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double wind;

  Weather({
    required this.icon,
    required this.wind,
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      wind: json['wind']['speed'].toDouble(),
    );
  }
}
