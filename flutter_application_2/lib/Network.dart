// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart';

import 'WeatherModels.dart';

class Network {
  Future<Weather> getWeatherForecast({required String cityName}) async {
    var finalUrl = "https://api.openweathermap.org/data/2.5/forecast?q=" +
        cityName +
        "&appid=413bbd0853ce7d7d122f0b12d44d652b";
    final response = await get(Uri.parse(finalUrl));
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("weather data : ${response.body}");
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting weather forecast");
    }
  }
}
