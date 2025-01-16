import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/weather/data/models/weather.dart';
import 'package:test_task/features/weather/logic/weather_bloc.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, Weather?>(
      builder: (context, weather) {
        if (weather == null) {
          return Center(
            child: ElevatedButton(
              onPressed: () =>
                  context.read<WeatherCubit>().fetchWeatherByLocation(),
              child: const Text('Fetch Weather for Current Location'),
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(weather.cityName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(weather.description,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${weather.temperature.toStringAsFixed(1)}°C',
                          style: TextStyle(fontSize: 48)),
                      Image.network(
                          'http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                    ],
                  ),
                  Text('Wind Speed: ${weather.wind} m/s',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<WeatherCubit>().reset();
                  },
                  child: Text('Reset')),
            ],
          ),
        );
      },
    );
  }
}
