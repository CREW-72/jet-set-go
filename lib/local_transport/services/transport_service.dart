import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class TransportService {
  static final String _googleMapsApiKey = dotenv.env['GOOGLE_MAPS_API_KEY']!;

  /// Fetches route and duration for a given transport mode.
  static Future<Map<String, dynamic>> getDirections(
      Position origin, LatLng destination, String mode) async {
    try {
      final String url =
          "https://maps.googleapis.com/maps/api/directions/json?"
          "origin=${origin.latitude},${origin.longitude}"
          "&destination=${destination.latitude},${destination.longitude}"
          "&mode=$mode"
          "&key=$_googleMapsApiKey";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final polyline = route['overview_polyline']['points'];
          final String duration = route['legs'][0]['duration']['text']; // Extract duration

          return {
            "route": _decodePolyline(polyline),
            "duration": duration,
          };
        } else {
          debugPrint(" No routes found from API response.");
        }
      } else {
        debugPrint(" API Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      debugPrint(" Exception in getDirections: $e");
    }

    return {
      "route": [],
      "duration": "N/A",
    }; // Return empty route and "N/A" if API call fails
  }

  /// Decodes Google Maps polyline into a list of LatLng points.
  static List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }
}
