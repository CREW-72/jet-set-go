// lib/packing_tips.dart
import 'package:flutter/material.dart';
import 'package:jet_set_go/travel_choice.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Packing Tips"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 600,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blueGrey[400],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Welcome to Packing Tips and Suggestions",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20), // Add some space between the text and the icon
              Icon(Icons.luggage, color: Colors.white, size: 150), // Add the new icon
              SizedBox(height: 20), // Add some space between the icon and the button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TravelChoice(),
                    ),
                  );
                  // Add your onPressed code here!
                },
                icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                label: Text("Get Started"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 50), // Adjust button size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}