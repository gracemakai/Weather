import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';

import 'widgets/custom_text.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final WeatherController weatherController =
      Get.put<WeatherController>(WeatherController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() {
        if (weatherController.gettingWeatherData.isFalse) {
          return Container(
            height: 1.sh,
            width: 1.sw,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: weatherController.currentWeatherData.value.main!.temp! < 30
                  ? Colors.green
                  : Colors.redAccent,
              image: DecorationImage(
                image: const AssetImage('images/location_background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  CustomText(
                    "Tell us where you are",
                    textColor: Colors.white,
                    textOverflow: TextOverflow.visible,
                    fontSize: 18.sp,
                  ),
                  SizedBox(
                    height: 0.04.sh,
                  ),
                  InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false,
                        onSelect: (Country country) {
                          weatherController.pickedCountry.value = country;
                        },
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "Pick country",
                          textColor: Colors.white,
                          textOverflow: TextOverflow.visible,
                          fontSize: 14.sp,
                        ),
                        SizedBox(
                          height: 0.01.sh,
                        ),
                        Container(
                          // height: 0.04.sh,
                          width: 0.9.sw,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              weatherController.pickedCountry.value.displayNameNoCountryCode.toString(),
                              textColor: Colors.black,
                              textOverflow: TextOverflow.visible,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "What's the name of your city?",
                        fontSize: 14.sp,
                        textColor:  Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 0.01.sh,
                      ),
                      Container(
                        // height: 0.07.sh,
                        width: 0.9.sw,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Theme.of(context).backgroundColor, width: 1.5)),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "California",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                          ),

                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                          controller: weatherController.cityTextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field is required';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if(weatherController.cityTextController.text.isNotEmpty) {
                      weatherController.getCurrentWeather();
                    }
                  },
                  child: Container(
                    height: 0.05.sh,
                    width: 0.3.sw,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: CustomText(
                        "Search",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
                  SizedBox(
                    height: 0.03.sh,
                  ),
                  CustomText(
                    weatherController.currentWeatherData.value.fullLocation
                        .toString(),
                    textColor: Colors.white,
                    textOverflow: TextOverflow.visible,
                    fontSize: 20.sp,
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  Container(
                    width: 0.3.sw,
                    height: 0.003.sh,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  CustomText(
                    "Current weather",
                    textColor: Colors.white,
                    textOverflow: TextOverflow.visible,
                    fontSize: 16.sp,
                  ),
                  Container(
                    width: 0.3.sw,
                    height: 0.002.sh,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  CustomText(
                    "${WeatherStatus().getWeatherIcon(weatherController.currentWeatherData.value.cod!)} ${weatherController.currentWeatherData.value.weather!.first.main}",
                    textColor: Colors.white,
                    textOverflow: TextOverflow.visible,
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  CustomText(
                    WeatherStatus().getMessage(weatherController
                        .currentWeatherData.value.main!.temp!
                        .floor()),
                    textColor: Colors.white,
                    textOverflow: TextOverflow.visible,
                  ),
                  SizedBox(
                    height: 0.04.sh,
                  ),
                  CustomText(
                    "More",
                    textColor: Colors.white,
                    textOverflow: TextOverflow.visible,
                    fontSize: 16.sp,
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  Container(
                    width: 0.3.sw,
                    height: 0.002.sh,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        "Temperature",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        width: 0.03.sw,
                      ),
                      CustomText(
                        "${weatherController.currentWeatherData.value.main!.temp}°С",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        "Feels like",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        width: 0.03.sw,
                      ),
                      CustomText(
                        "${weatherController
                            .currentWeatherData.value.main!.feelsLike}°С",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        "Minimum temp",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        width: 0.03.sw,
                      ),
                      CustomText(
                        "${weatherController.currentWeatherData.value.main!.tempMin}°С",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        "Maximum temp",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        width: 0.03.sw,
                      ),
                      CustomText(
                        "${weatherController.currentWeatherData.value.main!.tempMax}°С",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        "Humidity",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        width: 0.03.sw,
                      ),
                      CustomText(
                        "${weatherController
                            .currentWeatherData.value.main!.humidity}%",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        "Wind speed",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        width: 0.03.sw,
                      ),
                      CustomText(
                        "${weatherController.currentWeatherData.value.wind!.speed}m/s",
                        textColor: Colors.white,
                        textOverflow: TextOverflow.visible,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: SpinKitDoubleBounce(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      }),
    );
  }
}

class WeatherStatus {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
