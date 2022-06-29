import 'dart:developer';

import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  /// Pass in the locationWeather response as a required parameter
  /// when instantiating this class
  const LocationScreen({required this.locationWeather, Key? key})
      : super(key: key);

  final dynamic locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  dynamic temperature;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '';
        cityName = '';
        weatherMessage = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMessage = weather.getMessage(temperature);

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);

      cityName = weatherData['name'];
      log(condition.toString());
    });
  }

  displaySb(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(ksnackBar(message));

  ksnackBar(String message) => SnackBar(
        duration: const Duration(milliseconds: 1200),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15.0),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        if (weatherData != null) {
                          updateUI(weatherData);
                        } else {
                          displaySb('No internet connection, please retry');
                        }
                        log(weatherData.toString());
                      },
                      child: Icon(
                        color: kdefaultColor,
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            // Navigate to the next screen when the button is pressed
                            builder: (context) => const CityScreen(),
                          ),
                        );
                        if (typedName != null) {
                          if (typedName != 'null') {
                            var weatherData =
                                await weather.getCityWeather(typedName);
                            if (weatherData != null) {
                              if (weatherData == 'Bad response') {
                                displaySb('$typedName is not a valid location');
                              } else {
                                updateUI(weatherData);
                              }
                            } else {
                              displaySb('No internet connection, please retry');
                            }
                          } else {
                            return;
                          }
                        } else {
                          displaySb('You did not type in a location');
                        }
                      },
                      child: Icon(
                        color: kdefaultColor,
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperature º',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName !",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
