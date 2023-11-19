import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../services/location.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  late TextEditingController _controller;
  String cityName = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City Name',
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                  // onSubmitted:,
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (cityName.isEmpty) {
                    return;
                  }
                  setState(() {
                    isLoading = true;
                  });

                  Location weatherModel = Location();
                  var decodedData = await weatherModel.getCityData(cityName);
                  Navigator.pop(context, decodedData);
                },
                child: Text(
                  isLoading ? 'Loading...' : 'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
