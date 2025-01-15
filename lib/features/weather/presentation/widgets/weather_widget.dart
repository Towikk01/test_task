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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text('City: ${weather.cityName}'),
                    Text('Temperature: ${weather.temperature}°C'),
                    Text('Condition: ${weather.description}'),
                    Text('Wind Speed: ${weather.wind} m/s'),
                    Image.network(
                        'http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                  ],
                ),
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
