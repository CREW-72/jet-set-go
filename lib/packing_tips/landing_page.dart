import 'package:flutter/material.dart';
import 'package:jet_set_go/packing_tips/travel_choice.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/packing_bg.jpg', // Replace with a relevant image
            fit: BoxFit.cover,
          ),

          // Gradient Overlay for Better Contrast
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(0, 0, 0, 0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Title
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 800),
                    builder: (context, double opacity, child) {
                      return Opacity(opacity: opacity, child: child);
                    },
                    child: Text(
                      "Smart Packing Starts Here!\n \n",
                      style: GoogleFonts.caveat(
                        textStyle: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 350),

                  // Glassmorphic Container
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        // Animated Button
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 900),
                          builder: (context, double scale, child) {
                            return Transform.scale(scale: scale, child: child);
                          },
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TravelChoice(),
                                ),
                              );
                            },
                            icon: Icon(Icons.flight_takeoff_rounded, color: Colors.white),
                            label: Text(
                              "Get Started",
                              style: GoogleFonts.lobster(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                              foregroundColor: Colors.white,
                              minimumSize: Size(220, 55),
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              shadowColor: Color.fromRGBO(0, 0, 255, 0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Standard Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: '',
          ),
        ],
      ),
    );
  }
}