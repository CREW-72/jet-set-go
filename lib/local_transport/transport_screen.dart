import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jet_set_go/local_transport/services/transport_service.dart';
import 'package:jet_set_go/local_transport/widgets/transport_options.dart';
import 'package:jet_set_go/local_transport/widgets/travel_options_sheet.dart';
import 'package:jet_set_go/homepages/homepage_registered_user.dart';


class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  TransportScreenState createState() => TransportScreenState();
}

class TransportScreenState extends State<TransportScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};
  String _journeyDuration = "Calculating...";


  static const LatLng _airportLocation = LatLng(7.1808, 79.8841);
  Position? _currentPosition;
  String _selectedMode = "driving"; // Default mode

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// Gets the user's current location and updates the map.
  Future<void> _getCurrentLocation() async {

    LocationPermission permission = await Geolocator.checkPermission();

    void showSnackbar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
    void showSettingsDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Location Access Required"),
            content: Text("Location permissions are permanently denied. Please enable them in settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Geolocator.openAppSettings(), // Opens settings
                child: Text("Open Settings"),
              ),
            ],
          );
        },
      );
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permissions are denied.");
        showSnackbar("Location access is required to get directions.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permissions are permanently denied. Ask user to enable in settings.");
      showSettingsDialog();
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
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
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );

    });

    _updateRoute();

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        12, // Adjust zoom level
      ),
    );
  }

  Future<void> _updateRoute() async {
    if (_currentPosition == null) return;

    Map<String, dynamic> routeData = await TransportService.getDirections(
      _currentPosition!,
      _airportLocation,
      _selectedMode,
    );

    setState(() {
      _polylines.clear();
      _journeyDuration = routeData["duration"];

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

  PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _airportLocation, zoom: 10),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            padding: EdgeInsets.only(bottom: 0),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/images/headerBackground.png", height: 160, fit: BoxFit.cover),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: Text(
              'TRANSPORT',
              style: GoogleFonts.ubuntu(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3.0,
              ),
            ),
          ),

          Positioned(
            top: 105,
            left: 24,
            child: Text(
              'ASSISTANCE',
              style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.white, letterSpacing: 2.0),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 135,left: 25),
            width: 275,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Positioned(
            top: 95,
            right: 80,
            child: Image.asset("assets/images/takeoff.png", height: 40),
          ),

          Positioned(
            top: 60,
            right: 15,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.menu, color: Colors.white, size: 40),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: Offset(0, 50),
              onSelected: (value) {
                switch (value) {
                  case 'Home':
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePageRegistered()),
                    );
                    break;
                  case 'Settings':
                    Navigator.pushNamed(context, '/settings');
                    break;
                  case 'Features':
                    Navigator.pushNamed(context, '/features');
                    break;
                  case 'Profile':
                    Navigator.pushNamed(context, '/profile');
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  _buildMenuItem(Icons.home, 'Home'),
                  _buildMenuItem(Icons.settings, 'Settings'),
                  _buildMenuItem(Icons.lightbulb, 'Features'),
                  _buildMenuItem(Icons.person, 'Profile'),
                ];
              },
            ),
          ),


          Positioned(
            top: 150,
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

          Positioned(
            top: 215,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FA),
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
                  Icon(Icons.access_time, color: Color(0xFF0A2647)),
                  SizedBox(width: 8),
                  Text(
                    "Estimated Time: $_journeyDuration",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B2B2B)
                    ),
                  ),
                ],
              ),
            ),
          ),

          TravelOptionsSheet(),
        ],
      ),
    );
  }
}
