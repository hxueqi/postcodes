import 'package:http/http.dart' as http;
import 'package:postcodes/models/current.dart';
import 'package:postcodes/models/weather_response.dart';

class WeatherApi {
  /// Gets the current weather at the given coordinates.
  /// Throws an exception when the request fails.
  static Future<Current> getCurrent(double latitude, double longitude) async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current': 'temperature_2m,weather_code,wind_speed_10m',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Server error: ${response.statusCode}');
    }

    return weatherResponseFromJson(response.body).current;
  }
}
