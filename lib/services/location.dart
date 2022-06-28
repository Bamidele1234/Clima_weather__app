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
      LocationPermission permission;
      permission = await Geolocator
          .checkPermission(); // First checks to see if Location permissions for the app has been enabled

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location Permissions are denied');
        }
      }

      Position position = await Geolocator
          .getCurrentPosition(); // If access is denied an exception is thrown here

      // Finally assign the locator values into longitude and latitude.
      latitude = position.latitude;
      longitude = position.longitude;
      return;
    } catch (e) {
      log(e.toString()); // todo: You have some error catching work to do here
    }
  }
}
