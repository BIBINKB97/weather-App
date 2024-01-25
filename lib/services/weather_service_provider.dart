import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/secrets/api.dart';
import 'package:http/http.dart' as http;

class WeatherServiceProvider extends ChangeNotifier {
  WeatherModel? _weather;
  WeatherModel? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _error = "";
  String get error => _error;

  Future<void> fetchWeatherDateByCity(String city) async {
    _isLoading = true;
    _error = "";

    try {
      final apiUrl =
          "${ApiEndPoints().cityUrl}$city&appid=${ApiEndPoints().apiKey}${ApiEndPoints().unit}";

      final responce = await http.get(Uri.parse(apiUrl));
      if (responce.statusCode == 200) {
        final data = jsonDecode(responce.body);

        print(data);

        _weather = WeatherModel.fromJson(data);

        notifyListeners();
      } else {
        _error = "Failed to load data";
      }
    } catch (e) {
      _error = "Failed to load data $e";
    } finally {
      _isLoading = false;
      notifyListeners();

    }
  }
}
