import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/airport_node.dart';

class LocalStorageService {
  static Future<void> cacheAirportNodes(List<AirportNode> nodes) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('airport_nodes', jsonEncode(nodes.map((n) => n.toJson()).toList()));
  }

  static Future<List<AirportNode>> getCachedAirportNodes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('airport_nodes');
    if (data == null) return [];
    return (jsonDecode(data) as List).map((e) => AirportNode.fromJson(e)).toList();
  }

  static Future<void> saveLastKnownLocation(LatLng location) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('last_location', jsonEncode({'lat': location.latitude, 'lng': location.longitude}));
  }

  static Future<LatLng?> getLastKnownLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('last_location');
    if (data == null) return null;
    final decoded = jsonDecode(data);
    return LatLng(decoded['lat'], decoded['lng']);
  }
}
