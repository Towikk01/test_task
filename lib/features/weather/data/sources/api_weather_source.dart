import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_task/core/utils/constants.dart';

//good practice to create a separate class for the API calls
//we use dio for making the API calls
//i choose dio because it is easy to use and has a lot of features like interceptors, transformers, etc.

class WeatherApi {
  static var apiKey = Constants.apiKey;
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
