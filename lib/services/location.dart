import 'dart:developer';
import 'package:geolocator/geolocator.dart';

/// The [Location] class is dedicated to getting the
/// location and assigning them to the [longitude] and [latitude]
class Location {
  Location({this.longitude = 0, this.latitude = 0});
  double longitude;
  double latitude;

  // Use the Geolocation library to get the current location
  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      log(longitude.toString());
      log(latitude.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
