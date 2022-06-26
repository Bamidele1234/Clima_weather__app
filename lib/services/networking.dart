import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

/// The [NetworkHelper] class is dedicated to making
/// the request to [https://openweathermap.org/]
/// and decoding the response to a .json format
class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    log('I got executed');
    http.Response response = await http.get(
        Uri.parse(url)); // This is the Judas Iscariot, filthy piece of sh*t

    if (response.statusCode == 200) {
      // If the request is successful
      String body = response.body;

      return jsonDecode(body);
    } else {
      log(response.statusCode.toString());
    }
  }
}
