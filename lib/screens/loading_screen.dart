import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    log('Latitude = ${location.latitude.toString()}');
    log('Longitude = ${location.longitude.toString()}');
  }

  getData() async {
    // Configure the http request to the RESTful server
    var url = Uri.parse(
        'https://api.unsplash.com/photos/random?count=1&orientation=portrait&client_id=GGHMWCsUFRHVRCL5jHePT2dzymk20ixPeV1bkOXKrZI');
    Response response = await get(url);
    log(response.persistentConnection.toString());
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
