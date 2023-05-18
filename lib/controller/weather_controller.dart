import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/city_model.dart';
import 'package:weather_app/model/country_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/utils/functions.dart';

import '../screens/widgets/custom_snack_bar.dart';
import '../services/weather_service.dart';

class WeatherController extends GetxController {
  var currentWeatherData = WeatherModel().obs;
  var gettingWeatherData = false.obs;
  var pickedCountry = CountryModel(name: "United states").obs;
  var pickedCity = City(name: "California").obs;
  var countries = <CountryModel>[].obs;
  var cities = <City>[].obs;

  var cityTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    readCountriesJson();
    getCurrentWeather();
  }

  getCurrentWeather() async {
    try {
      gettingWeatherData.value = true;

      var city = pickedCity.value.name ?? "California";

      var weather = await WeatherService().getWeather(city, pickedCountry.value.shortName ?? "US");

      if (weather != null) {
        currentWeatherData.value = WeatherModel.fromJson(weather);

        List<Placemark> placeMarks = await placemarkFromCoordinates(
            currentWeatherData.value.coord!.lat!.toPrecision(4),
            currentWeatherData.value.coord!.lon!.toPrecision(4));

        currentWeatherData.value.fullLocation =
            "${placeMarks.first.locality}, ${placeMarks.first.country}";

      } else {
        customSnackBar(
          title: "Error",
          message:
              "City not found",
        );
      }
    } catch (e, s) {
      printOut("error $e");
      customSnackBar(
        title: "Error",
        message:
            "Something happened. We were not able to fetch your weather data. Try again later.",
      );
    } finally {
      gettingWeatherData.value = false;
    }
  }

  Future<void> readCountriesJson() async {
    final String response = await rootBundle.loadString('assets/json/countries.json');
    final data = await json.decode(response);
    if(data != null) {
      List countriesList = data;
      countries.value = countriesList.map((e) => CountryModel.fromJson(e)).toList();
    }

    printOut("Countries length ${countries.length}");
  }

  Future<void> readCitiesJson(int id) async {
    final String response = await rootBundle.loadString('assets/json/cities.json');
    final data = await json.decode(response);
    if(data != null) {

      List countriesList = data;
      cities.value = CityModel.fromJson(countriesList.firstWhere((element) => element["country"] == id)).cities ?? [];
    }

    printOut("Cities length ${cities.length}");
  }
}
