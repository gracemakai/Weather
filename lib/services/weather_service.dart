import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_app/services/end_points.dart';
import 'package:weather_app/utils/functions.dart';

import '../utils/keys.dart';
import 'base_service.dart';

class WeatherService {

   getWeather(String city, String country) async {
    try {

      var response = await BaseService().databaseRequest(
          "$weather?q=$city,$country&appid=$apiKey&units=metric",
          BaseService().getRequestType);

      printOut("response $response");
      return jsonDecode(response);
    }  catch (e, s) {
       if (kDebugMode) {
         print("$e, $s");
       }
    }
  }
}