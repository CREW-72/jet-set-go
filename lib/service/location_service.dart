import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  // Check if location service is enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Get location permission status
  Future<PermissionStatus> getLocationPermissionStatus() async {
    return await Permission.location.status;
  }

  // Request location permission
  Future<PermissionStatus> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status;
  }

  // Get current location
  Future<LatLng?> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return null;
    }
  }

  // Get location stream
  Stream<LatLng?> getLocationStream() {
    return Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // Update location every 10 meters
        ))
        .map((Position position) => LatLng(position.latitude, position.longitude))
        .handleError((error) {
      return null; // Or handle the error differently
    });
  }
}