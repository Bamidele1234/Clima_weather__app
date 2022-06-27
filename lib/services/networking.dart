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
    dynamic res;
    try {
      // Check if there's internet connectivity
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If the request is successful
        String body = response.body;

        res = jsonDecode(body);
      } else {
        log(response.statusCode.toString());
      }
      return res;
    } catch (e) {
      return;
    }
  }
}
