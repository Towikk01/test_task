import 'package:bloc/bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:test_task/features/weather/data/sources/api_weather_source.dart';
import '../data/models/weather.dart';

class WeatherCubit extends Cubit<Weather?> {
  WeatherCubit() : super(null);

  void reset() {
    emit(null);
  }

  Future<void> fetchWeatherByLocation() async {
    checkLocationPermissions();
    try {
      final position = await Geolocator.getCurrentPosition();

      final response = await WeatherApi().getWeather(position);

      emit(Weather.fromJson(response.data));
    } catch (e) {
      emit(null);
      print('Error fetching weather by location: $e');
    }
  }

  Future<void> checkLocationPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }
  }
}
