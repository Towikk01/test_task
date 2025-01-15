import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_task/core/utils/constants.dart';

class WeatherApi {
  static const apiKey = API_KEY;
  final Dio dio = Dio();

  Future<Response> getWeather(Position position) async {
    return await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'lat': position.latitude,
        'lon': position.longitude,
        'appid': apiKey,
        'units': 'metric',
        'lang': 'en',
      },
    );
  }
}
