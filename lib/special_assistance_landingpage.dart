import 'package:flutter/material.dart';
import 'package:jet_set_go/specialAssistance.dart';
import 'package:jet_set_go/special_assistance_styling.dart';

class SpecialAssistanceLandingPage extends StatelessWidget {
  const SpecialAssistanceLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UI(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            top:130,
            child: Image.asset(
              "assets/elder Passenger.jpg", // Path to the image
              fit: BoxFit.cover, // Ensures full-screen coverage
            ),
          ),
          // Gradient Overlay (Improved)
          // Foreground Content
          Padding(
            padding: const EdgeInsets.only(bottom: 20), // Moves container up
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 350,
                height: 250,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Improved Text Layout
                    Text.rich(
                      TextSpan(
                        text: "Receive Guidance\n",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "On\n",
                            style: TextStyle(fontSize: 28, color: Colors.blue[900],fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "Special Assistance",
                            style: TextStyle(fontSize: 28,color: Colors.blue[900], fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Call-to-Action Button
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SpecialAssistance()),
                        );
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                      label: Text("Continue", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        foregroundColor: Colors.white,
                        minimumSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}