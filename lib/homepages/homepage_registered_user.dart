import 'package:flutter/material.dart';
import 'package:jet_set_go/packing_tips/landing_page.dart';
import 'package:jet_set_go/document_upload/document_selection_page.dart';
import 'package:jet_set_go/special_assistance/special_assistance_landing_page.dart';
import 'package:jet_set_go/local_transport/transport_screen.dart';
import 'package:jet_set_go/airport_navigation/map_screen.dart';
import 'package:jet_set_go/travel_tips.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // TOP IMAGE WITH HAMBURGER MENU
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

                // HAMBURGER MENU
                Positioned(
                  top: 50,
                  right: 15,
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.menu, color: Colors.black, size: 40), // BLACK Icon
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    offset: Offset(0, 50), // Moves menu lower
                    onSelected: (value) {
                      switch (value) {
                        case 'Home':
                          Navigator.pushNamed(context, '/home');
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

          // WELCOME BACK MESSAGE (Stays in place)
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
                'WELCOME BACK, USER!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // CURRENT TRIP BUTTON (TEXT MOVED TO TOP-LEFT WITHOUT AFFECTING SIZE)
          Positioned(
            top: 300,
            left: 10,
            right: 10,
            child: SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    );
                  },
                  child: SizedBox(
                    height: 130, // Keeps button height fixed
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10, // Moves text to the top
                          left: 16, // Keeps text left-aligned
                          child: Text(
                            'Current Trip',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),


          // FEATURE BUTTONS (Reduced size + 2 extra buttons)
          Positioned(
            top: 440,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildFeatureButton("assets/images/document.png", "Document",DocumentSelectionPage()),
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
                    _buildFeatureButton("assets/images/travel.png", "Travel Tips",TravelTipsApp()),
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

  // Helper function for menu items
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

  // Helper function to build feature buttons
  Expanded _buildFeatureButton(String imagePath, String title, Widget page) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: InkWell(
          onTap: () {
            // Navigate to the assigned page
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
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
