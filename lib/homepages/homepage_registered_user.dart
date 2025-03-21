import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jet_set_go/packing_tips/landing_page.dart';
import 'package:jet_set_go/document_upload/document_selection_page.dart';
import 'package:jet_set_go/special_assistance/special_assistance_landing_page.dart';
import 'package:jet_set_go/local_transport/transport_screen.dart';
import 'package:jet_set_go/airport_navigation/map_screen.dart';
//import 'package:jet_set_go/travel_tips.dart';
import 'package:jet_set_go/flight_tracking/flight_tracking_page.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePageRegistered extends StatefulWidget {
  const HomePageRegistered({super.key});

  @override
  HomePageRegisteredState createState() => HomePageRegisteredState();
}

class HomePageRegisteredState extends State<HomePageRegistered> {
  String username = "User";

  @override
  void initState() {
    super.initState();
    _fetchUsername();
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.withAlpha(35), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                "assets/images/planebg.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flight.origin.code,
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textColor),
                      ),
                      Text(
                        flight.origin.city,
                        style: TextStyle(fontSize: 16, color: subtitleColor),
                      ),
                      SizedBox(height: 6),
                      Text(
                        _formatFlightTime(flight.departure),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: accentColor),
                      ),
                      Text(
                        _formatFlightDate(flight.departure),
                        style: TextStyle(fontSize: 16, color: subtitleColor),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.flight_takeoff,
                        size: 30,
                        color: accentColor,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 1,
                        color: textColor,
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        Icons.flight_land,
                        size: 30,
                        color: accentColor,
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        flight.destination.code,
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textColor),
                      ),
                      Text(
                        flight.destination.city,
                        style: TextStyle(fontSize: 16, color: subtitleColor),
                      ),
                      SizedBox(height: 6),
                      Text(
                        _formatFlightTime(flight.arrival),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: accentColor),
                      ),
                      Text(
                        _formatFlightDate(flight.arrival),
                        style: TextStyle(fontSize: 16, color: subtitleColor),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  Future<DocumentSnapshot<Object?>> _fetchUserFlight() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      if (userData == null || !userData.containsKey('flightNumber')) {
        throw Exception("No flight number found for user.");
      }

      String flightNumber = userData['flightNumber'];

      DocumentSnapshot flightDoc = await FirebaseFirestore.instance.collection('flights').doc(flightNumber).get();

      if (flightDoc.exists) {
        return flightDoc;
      } else {
        throw Exception("No active flight found.");
      }
    }
    throw Exception("User not logged in");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  height: 260,
                  fit: BoxFit.cover,
                  width: double.infinity,
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
              ],
            ),
          ),

          Positioned(
            top: 250,
            left: 10,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [Colors.blue, Colors.cyanAccent, Colors.red, Colors.orange],
                  tileMode: TileMode.mirror,
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
              },
              child: Text(
                'WELCOME BACK, ${username.isNotEmpty ? username.toUpperCase() : "USER"}!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            top: 300,
            left: 10,
            right: 10,
            child: FutureBuilder<DocumentSnapshot>(
              future: _fetchUserFlight(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return SizedBox(
                    height: 130,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: Center(
                        child: Text("No active flight", style: TextStyle(fontSize: 18, color: Colors.red)),
                      ),
                    ),
                  );
                }

                Flight flight = _mapToFlight(snapshot.data!);

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlightTrackingPage()),
                    );
                  },
                  child: _buildFlightHeader(flight),
                );
              },
            ),
          ),


          // feature buttons
          Positioned(
            top: 460,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildFeatureButton("assets/images/document.png", "Document Upload",DocumentSelectionPage()),
                    _buildFeatureButton("assets/images/wheelchair.png", "Special Assistance",SpecialAssistanceLandingPage()),
                  ],
                ),
                Row(
                  children: [
                    _buildFeatureButton("assets/images/taxi.png", "Transport",TransportScreen()),
                    _buildFeatureButton("assets/images/map.png", "Airport Navigation",MapScreen()),
                  ],
                ),
                Row( // New row for additional feature buttons
                  children: [
                    _buildFeatureButton("assets/images/travel.png", "Travel Tips",LandingPage()),
                    _buildFeatureButton("assets/images/luggage.png", "Packing Tips",LandingPage()),
                  ],
                ),
              ],
            ),
          ),
        ],
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

  Expanded _buildFeatureButton(String imagePath, String title, Widget page) {
    return Expanded(
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
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Keep padding small
              child: Column(
                children: [
                  Image.asset(imagePath, height: 80, width: 150), // Smaller size
                  SizedBox(height: 5),
                  Text(
                    title,
                    style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
