import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jet_set_go/services/transport_service.dart';
import 'package:jet_set_go/widgets/transport_options.dart';
import 'package:jet_set_go/widgets/travel_options_sheet.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load API key from .env
  runApp(const TransportTestApp());
}

class TransportTestApp extends StatelessWidget {
  const TransportTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Transport Assistance Test",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TransportScreen(),
    );
  }
}

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  TransportScreenState createState() => TransportScreenState();
}

class TransportScreenState extends State<TransportScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};
  String _journeyDuration = "Calculating..."; // Add this to store duration


  static const LatLng _airportLocation = LatLng(7.1808, 79.8841);
  Position? _currentPosition;
  String _selectedMode = "driving"; // Default mode is Car

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// Gets the user's current location and updates the map.
  Future<void> _getCurrentLocation() async {

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are denied. Go to settings to enable.");
      return;
    }


    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
      _markers.clear();

      _markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: "Your Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      _markers.add(
        Marker(
          markerId: MarkerId("airport"),
          position: LatLng(7.1808, 79.8841), // Airport coordinates
          infoWindow: InfoWindow(title: "Bandaranaike International Airport"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Red marker for airport
        ),
      );

    });

    _updateRoute(); // Fetch route after getting location

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        12, // Adjust zoom level
      ),
    );
  }

  /// Fetches and updates the route on the map when mode changes.
  Future<void> _updateRoute() async {
    if (_currentPosition == null) return;

    Map<String, dynamic> routeData = await TransportService.getDirections(
      _currentPosition!,
      _airportLocation,
      _selectedMode,
    );

    setState(() {
      _polylines.clear();
      _journeyDuration = routeData["duration"]; // Update duration text

      if (routeData["route"].isNotEmpty) {
        _polylines.add(
          Polyline(
            polylineId: PolylineId("route"),
            points: routeData["route"],
            color: Colors.blue,
            width: 5,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Transport Assistance",
            style: TextStyle(
              color: Colors.white,
            ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _airportLocation, zoom: 10),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),

          Positioned(
            top: 85,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, color: Colors.blue[900]),
                  SizedBox(width: 8),
                  Text(
                    "Estimated Time: $_journeyDuration",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 20,
            left: 10,
            right: 10,
            child: TransportOptions(
              onModeChanged: (mode) {
                setState(() {
                  _selectedMode = mode;
                });
                _updateRoute();
              },
            ),
          ),
          TravelOptionsSheet(),
        ],
      ),
    );
  }
}
