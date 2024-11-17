import 'package:first_project_dart/services/weather_service.dart';
import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService("aaa4b7885b5db43673480bfd2ba5f6d5");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();

    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/loading.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'haze':
        return 'assets/cloud.json';
      case 'thunderstorm':
      case 'snow':
      case 'dust':
      case 'sand':
        return 'assets/thunder.json';
      case 'rain':
      case 'drizzle':
      case 'fog':
      case 'smoke':
        return 'assets/rain.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 157, 157),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/location.svg',
              width: 80,
              height: 80,
            ),
            Text(_weather?.cityName ?? "Loading city name..."),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C'),
            Text(_weather?.mainCondition ?? "Loading condition..."),
          ],
        ),
      ),
    );
  }
}
