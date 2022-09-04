import 'package:country_picker/country_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/weather_model.dart';

import '../screens/widgets/custom_snack_bar.dart';
import '../services/weather_service.dart';

class WeatherController extends GetxController {
  var currentWeatherData = WeatherModel().obs;
  var gettingWeatherData = false.obs;
  var pickedCountry = Country(phoneCode: "+1", countryCode: "US", e164Sc: 0,
      geographic: true, level: 1, name: "United States", example: "2012345678",
      displayName: "United States (US) [+1]", displayNameNoCountryCode: "United States (US)", e164Key: "1-US-0").obs;
  var pickedCity = "".obs;

  var cityTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    getCurrentWeather();
    cityTextController.text = "California";
  }

  getCurrentWeather() async {
    try {
      gettingWeatherData.value = true;

      var city = cityTextController.text.isNotEmpty ? cityTextController.text.toString() : "California";

      var weather = await WeatherService().getWeather(city, pickedCountry.value.countryCode);

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
      customSnackBar(
        title: "Error",
        message:
            "Something happened. We were not able to fetch your weather data. Try again later.",
      );
    } finally {
      gettingWeatherData.value = false;
    }
  }
}
