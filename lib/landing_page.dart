import 'package:flutter/material.dart';
import 'package:jet_set_go/travel_choice.dart';

class LandingPage extends StatelessWidget {
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

          // Dark Overlay for better text contrast
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Packing Tips & Suggestions",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 580),

                  // Container with rounded corners and transparency
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1), // Transparent color
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Get Started Button
                        ElevatedButton.icon(
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
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade700,
                            foregroundColor: Colors.white,
                            minimumSize: Size(220, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
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
    );
  }
}