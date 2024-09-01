import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';
import '../services/weather_api.dart';
import '../utils/logger.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? weather;
  String? cityName;
  String currentDate = DateFormat('dd, MMMM, yyyy').format(DateTime.now());

  Future<void> fetchWeather(String city) async {
    try {
      Logger.log('Fetching weather for $city', tag: 'WeatherViewModel');
      weather = await WeatherApi.getWeather(city);
      Logger.log('Weather fetched: ${weather?.condition}, ${weather?.temperature}°C, Feels like: ${weather?.feelsLike}°C', tag: 'WeatherViewModel');
      notifyListeners();  // Notify listeners after the weather is fetched
    } catch (e) {
      Logger.error('Failed to fetch weather: $e', tag: 'WeatherViewModel');
    }
  }

  Future<void> fetchLocationAndWeather() async {
    try {
      Position position = await _determinePosition();
      cityName = await _getCityNameFromPosition(position);
      if (cityName != null) {
        await fetchWeather(cityName!);
      }
    } catch (e) {
      Logger.error('Failed to fetch location or weather: $e', tag: 'WeatherViewModel');
    }
  }

  Future<Position> _determinePosition() async {
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
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String?> _getCityNameFromPosition(Position position) async {
    try {
      String city = "Peshawar"; // Replace with actual implementation
      return city;
    } catch (e) {
      Logger.error('Failed to get city name from position: $e', tag: 'WeatherViewModel');
      return null;
    }
  }
}
