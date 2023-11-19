import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../utilities/constants.dart';

class Location {
  late double latitude;
  late double longitude;
  Location();

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('error');
    }
  }

  Future getCityData(String cityName) async {
    try {
      http.Response response = await http.get(Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {
          'q': cityName,
          'appid': apiKey,
          'units': 'metric',
        },
      ));

      if (response.statusCode == 200) {
        var data = response.body;
        var decodedData = jsonDecode(data);

        return decodedData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
