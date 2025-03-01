import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jet_set_go/service/firebase_service.dart';
import 'package:jet_set_go/service/location_service.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;

import '../widgets/destination_search.dart';
import 'model/airport_node.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //late GoogleMapController mapController;
  final Completer<GoogleMapController> mapController = Completer();// to ensure that the GoogleMapController is properly initialized


  LatLng? _currentLocation;
  bool _isLoading = true;
  final LocationService _locationService = LocationService();
  final FirebaseService _firebaseService = FirebaseService(); // Or LocalDataService()
  List<AirportNode> _airportNodes = [];
  AirportNode? _selectedDestination; // Track selected destination

  @override
  void initState() {
    super.initState();
    _loadAirportData();
    _checkLocationServiceAndPermission();
  }

  Future<void> _loadAirportData() async {
    _airportNodes = await _firebaseService.getAirportNodes(); // Or load locally
    setState(() {});
  }

  Future<void> _checkLocationServiceAndPermission() async {
    bool isEnabled = await _locationService.isLocationServiceEnabled();
    //loc.PermissionStatus permissionStatus = (await _locationService.getLocationPermissionStatus()) as loc.PermissionStatus;
    perm.PermissionStatus permStatus = await perm.Permission.location.request();
    loc.PermissionStatus locStatus = await loc.Location().hasPermission();

    if (isEnabled) {
      if (locStatus == loc.PermissionStatus.denied ||
          locStatus == loc.PermissionStatus.deniedForever) {
        _requestLocationPermission();
      } else {
        _getCurrentLocation();
      }
    } else {
      // Handle case where location service is disabled
      print("Location service is disabled");
      setState(() {
        _isLoading = false;
      });
    }
  }
  ///////////////////////added///////////////
  Future<void> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }
  /////////////////////////////////////////

  Future<void> _requestLocationPermission() async {
    final status = await _locationService.requestLocationPermission();
    if (status == loc.PermissionStatus.granted) {
      _getCurrentLocation();
    } else {
      // Handle denied permission
      print("Location permission denied");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    _currentLocation = await _locationService.getCurrentLocation();
    if (_currentLocation != null) {
      //mapController.animateCamera(
          //CameraUpdate.newLatLngZoom(_currentLocation!, 17));
      final GoogleMapController controller = await mapController.future; // ✅ Retrieve the controller
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation!, 17), // ✅ Animate to new location
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _showDestinationSearch() async {
    final GoogleMapController controller = await mapController.future;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DestinationSearch(
          airportNodes: _airportNodes,
          onDestinationSelected: (AirportNode destination) {
            setState(() {
              _selectedDestination = destination;
            });
            controller.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(destination.latitude, destination.longitude),
                18,
              ),
            );
            Navigator.pop(context);
          },
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (_currentLocation == null
              ? const Center(child: Text('Location not available.'))
              : GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation ??
                        LatLng(7.1762, 79.8829), // Airport as default
                    zoom: 17.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                )),
    );
  }
}