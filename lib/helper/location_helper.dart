import 'dart:convert';

import 'package:http/http.dart' as http;

const googleApiKey = 'AIzaSyA7a2MOVbCVPdaZuNXUSx2SWXqskOk2GkA';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude, $longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey';
    final response = await http.get(Uri.parse(url));
    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    if (responseBody['error_message'] != null) {
      print('[getPlaceAddress()] ' + responseBody['error_message']);
      return 'No address found for this location';
    }

    return responseBody['results'][0]['formatted_address'];
  }
}
