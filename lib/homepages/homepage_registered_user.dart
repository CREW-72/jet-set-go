import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jet_set_go/packing_tips/packing_landing_page.dart';
import 'package:jet_set_go/document_upload/document_selection_page.dart';
import 'package:jet_set_go/special_assistance/special_assistance_landing_page.dart';
import 'package:jet_set_go/local_transport/transport_screen.dart';
import 'package:jet_set_go/airport_navigation/navigation_landing.dart';
import 'package:jet_set_go/flight_tracking/flight_tracking_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/travel_tips/travel_tips.dart';
import 'package:jet_set_go/authentication/welcome_screen.dart';


class HomePageRegistered extends StatefulWidget {
  const HomePageRegistered({super.key});

  @override
  HomePageRegisteredState createState() => HomePageRegisteredState();
}

class HomePageRegisteredState extends State<HomePageRegistered> {
  String username = "User";
  Flight? _userFlight;


  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _fetchUserFlight();
  }

  Future<void> _fetchUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc.data() != null) {
          setState(() {
            username = userDoc['username'] ?? "User";
          });
        }
      } catch (e) {
        throw Exception("Error fetching username: $e");
      }
    }
  }

  String _formatFlightTime(FlightTime? flightTime) {
    if (flightTime == null || flightTime.scheduled == null) {
      return "N/A";
    }

    return "${flightTime.scheduled!.hour}:${flightTime.scheduled!.minute.toString().padLeft(2, '0')}";
  }

  String _formatFlightDate(FlightTime? flightTime) {
    if (flightTime == null || flightTime.scheduled == null) return "Unknown Date";

    DateTime date = flightTime.scheduled!;
    String formattedDate = "${_getWeekday(date.weekday)}, ${_getMonth(date.month)} ${date.day}";

    return formattedDate; //
  }

  String _getWeekday(int weekday) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return weekdays[weekday - 1];
  }

  String _getMonth(int month) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return months[month - 1];
  }


  Widget _buildFlightHeader(Flight flight) {
    Color backgroundColor = Color(0xFFF7F2FA);
    Color textColor = Color(0xFF1E3A5F);
    Color subtitleColor = Colors.black54;
    Color accentColor = Colors.blueAccent;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.015,
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.withAlpha(35), width: 1),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))],
        image: DecorationImage(
          image: AssetImage("assets/images/planebg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    flight.origin.code,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(height: 2),
                FittedBox(
                  child: Text(
                    flight.origin.city,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: subtitleColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 4),
                FittedBox(
                  child: Text(
                    _formatFlightTime(flight.departure),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    _formatFlightDate(flight.departure),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: subtitleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Flight Icons and Route
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flight_takeoff, size: MediaQuery.of(context).size.width * 0.07, color: accentColor),
              SizedBox(height: 6),
              Container(width: MediaQuery.of(context).size.width * 0.15, height: 2, color: textColor),
              SizedBox(height: 6),
              Icon(Icons.flight_land, size: MediaQuery.of(context).size.width * 0.07, color: accentColor),
            ],
          ),

          // Destination Airport Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FittedBox(
                  child: Text(
                    flight.destination.code,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(height: 2),
                FittedBox(
                  child: Text(
                    flight.destination.city,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: subtitleColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 4),
                FittedBox(
                  child: Text(
                    _formatFlightTime(flight.arrival),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    _formatFlightDate(flight.arrival),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: subtitleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _fetchUserFlight() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      if (userData == null || !userData.containsKey('flightNumber')) {
        setState(() => _userFlight = null); // no flight
        return;
      }

      String flightNumber = userData['flightNumber'];
      DocumentSnapshot flightDoc = await FirebaseFirestore.instance.collection('flights').doc(flightNumber).get();

      if (flightDoc.exists) {
        setState(() {
          _userFlight = _mapToFlight(flightDoc);
        });
      } else {
        setState(() => _userFlight = null);
      }
    }
  }





  DateTime? _parseDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString == "N/A") return null;

    try {
      return DateTime.parse(dateTimeString);
    } catch (e) {
      throw Exception("Error parsing DateTime: $e");
    }
  }

  Flight _mapToFlight(DocumentSnapshot flightDoc) {
    return Flight(
      airline: Airline(
        code: flightDoc['iata'],
        name: flightDoc['airlineName'],
      ),
      flightNumber: flightDoc['flightNumber'],

      origin: Airport(
        code: flightDoc['origin']['code'],
        name: flightDoc['origin']['name'],
        city: flightDoc['origin']['city'],
        terminal: flightDoc['origin']['terminal'],
        gate: flightDoc['origin']['gate'],
      ),

      destination: Airport(
        code: flightDoc['destination']['code'],
        name: flightDoc['destination']['name'],
        city: flightDoc['destination']['city'],
        terminal: flightDoc['destination']['terminal'],
        gate: flightDoc['destination']['gate'],
      ),

      departure: FlightTime(
        scheduled: _parseDateTime(flightDoc['scheduledDeparture']),
        estimated: _parseDateTime(flightDoc['estimatedDeparture']),
        actual: _parseDateTime(flightDoc['actualDeparture']),
      ),

      arrival: FlightTime(
        scheduled: _parseDateTime(flightDoc['scheduledArrival']),
        estimated: _parseDateTime(flightDoc['estimatedArrival']),
        actual: _parseDateTime(flightDoc['actualArrival']),
      ),

      status: FlightStatus.values.firstWhere(
            (e) => e.toString() == 'FlightStatus.${flightDoc['status']}',
        orElse: () => FlightStatus.onTime, // Default status if missing
      ),
    );
  }

  void _signOutAndRedirect(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // image with hamburger menu
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/planeimage1.png",
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),

                    //menu
                    Positioned(
                      top: 50,
                      right: 15,
                      child: PopupMenuButton<String>(
                        icon: Icon(Icons.menu, color: Colors.black, size: 40),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        offset: Offset(0, 50),
                        onSelected: (value) {
                          switch (value) {
                            case 'Home':
                              Navigator.pushNamed(context, '');
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
                            case 'Sign Out':
                              _signOutAndRedirect(context);
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            _buildMenuItem(Icons.home, 'Home'),
                            _buildMenuItem(Icons.settings, 'Settings'),
                            _buildMenuItem(Icons.lightbulb, 'Features'),
                            _buildMenuItem(Icons.person, 'Profile'),
                            _buildMenuItem(Icons.logout, 'Sign Out'),
                          ];
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.28,
                left: MediaQuery.of(context).size.width * 0.03,
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [Colors.blue, Colors.cyanAccent, Colors.red, Colors.orange],
                      tileMode: TileMode.mirror,
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                  },
                  child: Text(
                    'WELCOME BACK, ${username.isNotEmpty ? username.toUpperCase() : "USER"}!',
                    style: GoogleFonts.ubuntu(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.34,
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlightTrackingPage()),
                    );
                    _fetchUserFlight(); // Refresh on return
                  },
                  child: _userFlight == null
                      ? Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4A90E2), Color(0xFF00B4DB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Click here to track your flight",
                        style: GoogleFonts.ubuntu(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                      : _buildFlightHeader(_userFlight!),
                ),
              ),

              // feature buttons
              Positioned(
                top: MediaQuery.of(context).size.height * 0.57,
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.02,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensures equal spacing
                      children: [
                        _buildFeatureButton("assets/images/document.png", "Document Upload", DocumentSelectionPage()),
                        _buildFeatureButton("assets/images/wheelchair.png", "Special Assistance", SpecialAssistanceLandingPage()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeatureButton("assets/images/taxi.png", "Transport", TransportScreen()),
                        _buildFeatureButton("assets/images/map.png", "Airport Navigation", NavigationLanding()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeatureButton("assets/images/travel.png", "Travel Tips", TravelTipsApp()),
                        _buildFeatureButton("assets/images/luggage.png", "Packing Tips", PackingLandingPage()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
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

  Widget _buildFeatureButton(String imagePath, String title, Widget page) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.48,
      height: MediaQuery.of(context).size.height * 0.13,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/planebg.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imagePath, height: MediaQuery.of(context).size.height * 0.07),
                SizedBox(height: 5),
                Text(
                  title,
                  style: GoogleFonts.ubuntu(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
