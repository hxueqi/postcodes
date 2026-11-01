import 'package:http/http.dart' as http;
import 'package:postcodes/models/place.dart';
import 'package:postcodes/models/search_response.dart';

class GeocodingApi {
  /// Searches places in Spain by postcode or name.
  ///
  /// Returns an empty list when nothing is found.
  /// Throws an exception when the request fails (no internet, server error).
  static Future<List<Place>> search(String query) async {
    final uri = Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
      'name': query,
      'language': 'ca',
      'countryCode': 'ES',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Server error: ${response.statusCode}');
    }

    return searchResponseFromJson(response.body).results;
  }
}
