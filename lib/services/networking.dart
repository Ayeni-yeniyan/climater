import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utilities/constants.dart';

class Network {
  final double latitude;
  final double longitude;
  Network({required this.latitude, required this.longitude});

  Future getData() async {
    try {
      http.Response response = await http.get(Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {
          'lat': '$latitude',
          'lon': '$longitude',
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
