import 'dart:convert';

import 'package:bloc_learning/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<WeatherModel> fetchWeatherByLocation(String location) async {
    final response = await http.get(Uri.parse(
        'https://openweathermap.org/data/2.5/find?q=$location&appid=439d4b804bc8187953eb36d2a8c26a02&units=metric'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body)["list"][0];
      print(data);
      WeatherModel model = WeatherModel.fromJson(data);
      print(model);
      return model;
    } else {
      throw Exception('No data available!');
    }
  }
}
