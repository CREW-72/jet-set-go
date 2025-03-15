import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:jet_set_go/maps_styling.dart';
import 'dart:convert';
import 'package:jet_set_go/widgets/search_destination.dart';
import 'package:jet_set_go/widgets/custom_info_window.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(7.1741265, 79.8863501),
    zoom: 18,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  Position? _currentPosition;
  LatLng? _selectedPosition;

  final String _googleMapsApiKey = "AIzaSyABCiY42Xyt3NYRw79vDRz0uJPCSTIWIwY";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    setState(() {
      _currentPosition = position;
      _markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: "Your Location"),
        ),
      );
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );
  }

  Future<void> _searchAndNavigate() async {
    Prediction? prediction = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchDestination.searchDestination(apiKey: _googleMapsApiKey),
      ),
    );

    if (prediction != null) {
      GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: _googleMapsApiKey);
      PlacesDetailsResponse detail =
      await places.getDetailsByPlaceId(prediction.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      _goToLocation(lat, lng);

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(prediction.placeId!),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: detail.result.name),
          ),
        );
      });
    }
  }

  Future<void> _goToLocation(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16),
    );
  }

  Future<void> _getDirections(LatLng destination) async {
    if (_currentPosition == null) return;
    final origin =
        "${_currentPosition!.latitude},${_currentPosition!.longitude}";
    final dest = "${destination.latitude},${destination.longitude}";

    final url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$dest&key=$_googleMapsApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['routes'].isNotEmpty) {
        final route = data['routes'][0];
        final polyline = route['overview_polyline']['points'];
        final List<LatLng> polylinePoints = _decodePolyline(polyline);
        setState(() {
          _polylines.add(
            Polyline(
              polylineId: PolylineId("route"),
              points: polylinePoints,
              color: Colors.blue,
              width: 5,
            ),
          );
        });
      }
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialPosition,
          markers: _markers,
          polylines: _polylines,
          myLocationEnabled: true,
          indoorViewEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (LatLng tappedPoint) {
            setState(() {
              _selectedPosition = tappedPoint;
              _markers.add(
                Marker(
                  markerId: MarkerId(tappedPoint.toString()),
                  position: tappedPoint,
                  infoWindow: InfoWindow(title: "Take Me Here"),
                ),
              );
            });
            _getDirections(tappedPoint);
          },
        ),
        if (_selectedPosition != null)
          Positioned(
            left: 16,
            bottom: 100,
            child: CustomInfoWindow(title: "Take Me Here"),
          ),
        Positioned(
          bottom: 100,
          right: 10,
          child: FloatingActionButton(
            backgroundColor: Colors.blue[900],
            onPressed: _searchAndNavigate,
            child: Icon(Icons.search, color: const Color(0xFFACE6FC)),
          ),
        ),
      ],
    );
  }
}