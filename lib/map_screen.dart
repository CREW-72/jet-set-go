import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jet_set_go/service/firebase_service.dart';
import 'package:jet_set_go/service/location_service.dart';
import 'package:jet_set_go/widgets/local_storage.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;

import '../widgets/destination_search.dart';
import 'model/airport_node.dart';

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/services.dart';

class PlayServicesChecker {
  static const MethodChannel _channel = MethodChannel('com.example.app/play_services');

  static Future<bool> isPlayServicesAvailable() async {
    try {
      final bool available = await _channel.invokeMethod('isPlayServicesAvailable');
      return available;
    } on PlatformException catch (e) {
      print("Failed to check Play Services: '${e.message}'.");
      return false; // Assume unavailable on error
    }
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> mapController = Completer(); // to ensure that the GoogleMapController is properly initialized

  bool _playServicesAvailable = true; // Default: assume available

  LatLng? _currentLocation;
  bool _isLoading = true;
  final LocationService _locationService = LocationService();
  final FirebaseService _firebaseService = FirebaseService(); // Or LocalDataService()
  List<AirportNode> _airportNodes = [];
  AirportNode? _selectedDestination; // Track selected destination

  @override
  void initState() {
    super.initState();
    print("initState is running...//////////////////////////////////////////"); // Add this line
    _checkPlayServices();
  }

  Future<void> _checkPlayServices() async {
    bool available = await PlayServicesChecker.isPlayServicesAvailable();
    setState(() {
      _playServicesAvailable = available;
    });
    if (!_playServicesAvailable) {
      // Handle the case where Play Services are unavailable (show a dialog, etc.)
      print("Google Play Services are not available!");
    }
    _loadAirportData(); // Load airport data *after* checking Play Services
    _checkLocationServiceAndPermission();
  }

  Future<void> _loadAirportData() async {
    try {
      _airportNodes = await _firebaseService.getAirportNodes();
      setState(() {});
      print('data loaded////////////////////////////////////////////');
    } catch (e) {
      print('/////////////////////////////////////////////Error loading airport data: $e'); // ADDED
    }
  }

  Future<void> _checkLocationServiceAndPermission() async {
    if (!await _locationService.isLocationServiceEnabled()) {
      print("Location service is disabled");
      setState(() => _isLoading = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _getCurrentLocation(); // Fetch only if granted
    } else {
      print("Location permission denied");
      setState(() => _isLoading = false);
    }
  }

  Future<void> _getCurrentLocation() async {
    LatLng? lastLocation = await LocalStorageService.getLastKnownLocation();
    if (lastLocation != null) {
      _currentLocation = lastLocation;
    } else {
      _currentLocation = await _locationService.getCurrentLocation();
      if (_currentLocation != null) {
        await LocalStorageService.saveLastKnownLocation(_currentLocation!);
      }
    }

    if (_currentLocation != null) {
      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(_currentLocation!, 17));
    }

    setState(() => _isLoading = false);
  }

  Future<void> _showDestinationSearch() async {
    print("Starting _showDestinationSearch...");
    final GoogleMapController controller = await mapController.future;
    print("GoogleMapController obtained.");

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        print("Showing DestinationSearch modal...");
        return DestinationSearch(
          airportNodes: _airportNodes,
          onDestinationSelected: (AirportNode destination) {
            print("Destination selected: ${destination.name}");
            setState(() {
              _selectedDestination = destination;
            });
            print("Animating camera to destination: ${destination.latitude}, ${destination.longitude}");
            controller.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(destination.latitude, destination.longitude),
                18,
              ),
            );
            Navigator.pop(context);
            print("Modal closed.");
          },
        );
      },
    );
  }

  void _onMapTapped(LatLng position) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Location Tapped'),
              Text('Latitude: ${position.latitude}'),
              Text('Longitude: ${position.longitude}'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Airport Navigation')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDestinationSearch,
        child: const Icon(Icons.search),
      ),
      body: _playServicesAvailable
          ? GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? LatLng(7.1762, 79.8829), // Airport as default
                zoom: 20.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: _onMapTapped,
            )
          : Center(child: Text('Google Play Services are not available.')),
    );
  }
}
