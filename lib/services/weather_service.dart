import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  // Primero buscamos las coordenadas de la ciudad usando la API de geocodificación gratuita de Open-Meteo
  Future<Map<String, dynamic>?> _getCoordinates(String city) async {
    final query = Uri.encodeComponent(city);
    final response = await http.get(Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=1&language=es&format=json'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['results'] != null && (data['results'] as List).isNotEmpty) {
        return data['results'][0];
      }
    }
    return null;
  }

  Future<WeatherModel?> getWeather({String city = 'Santo Domingo'}) async {
    try {
      final location = await _getCoordinates(city);
      if (location == null) {
        throw Exception('Ciudad no encontrada. Intenta con otro nombre.');
      }

      final lat = location['latitude'];
      final lon = location['longitude'];
      final cityName = location['name'];
      final country = location['country'] ?? '';

      final response = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=relativehumidity_2m&timezone=auto'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final current = data['current_weather'];
        final humidity = data['hourly']['relativehumidity_2m'][0];

        return WeatherModel(
          city: '$cityName, $country',
          temperature: current['temperature'],
          description: _getWeatherDescription(current['weathercode']),
          icon: _getWeatherIcon(current['weathercode']),
          humidity: humidity,
          windSpeed: current['windspeed'],
        );
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
    return null;
  }

  String _getWeatherDescription(int code) {
    if (code == 0) return 'Despejado';
    if (code <= 3) return 'Parcialmente nublado';
    if (code <= 48) return 'Niebla';
    if (code <= 57) return 'Llovizna';
    if (code <= 67) return 'Lluvia';
    if (code <= 77) return 'Nieve';
    if (code <= 82) return 'Chubascos';
    if (code <= 99) return 'Tormenta';
    return 'Desconocido';
  }

  String _getWeatherIcon(int code) {
    if (code == 0) return '☀️';
    if (code <= 3) return '⛅';
    if (code <= 48) return '🌫️';
    if (code <= 57) return '🌦️';
    if (code <= 67) return '🌧️';
    if (code <= 77) return '❄️';
    if (code <= 82) return '🌧️';
    if (code <= 99) return '⛈️';
    return '☁️';
  }
}
