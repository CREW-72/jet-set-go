import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/general_tips.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // Import the UI class

class WeatherBasedTips extends StatelessWidget {
  WeatherBasedTips({super.key});
  final List<Map<String, String>> tips = [
    {"title": "Check Destination Weather", "icon": "🌍", "desc": "Pack accordingly—warm layers for cold climates, light clothing for tropical destinations."},
    {"title": "Rain or Snow Preparedness", "icon": "☔", "desc": "Carry a compact umbrella or waterproof jacket to stay dry."},
    {"title": "Sun Protection", "icon": "🌞", "desc": "Pack sunscreen, sunglasses, and a hat for sunny destinations."},
    {"title": "Layering Strategy", "icon": "🧥", "desc": "Opt for layers instead of heavy clothing for better temperature control."},
    {"title": "Footwear Choices", "icon": "👟", "desc": "Waterproof boots for cold/wet areas; breathable shoes for hot regions."}
  ];

  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'CLIMATE',
      subtitle: 'CARRY-ON TIPS',
      body: Column(
        children: [
          SizedBox(height: 155),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: tips.map((tip) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Text(tip["icon"]!, style: TextStyle(fontSize: 24)),
                    title: Text(tip["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(tip["desc"]!),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(33.0),
            child: SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GeneralTips(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                label: Text(
                    "Next",
                  style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}