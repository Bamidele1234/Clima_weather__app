import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class Location {
  Location({this.longitude = 0, this.latitude = 0});
  double longitude;
  double latitude;

  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      log(e.toString());
    }
  }
}
