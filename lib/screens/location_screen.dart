import 'package:climater/screens/city_screen.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.weatherData});
  final dynamic weatherData;
  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late int id;
  late String cityName;

  @override
  void initState() {
    super.initState();
    updateData(widget.weatherData);
  }

  void updateData(dynamic decodedData) {
    setState(() {
      if (decodedData == null) {
        temperature = 0;
        id = 0;
        cityName = 'Unknown';
        return;
      }

      double temp = decodedData['main']['temp'];
      temperature = temp.toInt();
      id = decodedData['weather'][0]['id'];
      cityName = decodedData['name'];
    });
  }

  WeatherModel weatherModel = WeatherModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/location_background.jpg'),
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
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      var decodedData = await weatherModel.getLocationData();
                      updateData(decodedData);
                    },
                    icon: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var cityNameInputed = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityScreen()));
                      updateData(cityNameInputed);
                    },
                    icon: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherModel.getWeatherIcon(id),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherModel.getMessage(temperature)} in $cityName!",
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
