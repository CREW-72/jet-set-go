import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/efficient_packing_tips.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // Import the UI class

class TechTips extends StatelessWidget {
  TechTips({super.key});
  final List<Map<String, String>> tips = [
    {"title": "Universal Adapter", "icon": "🔌", "desc": "Ensure compatibility with different country power sockets."},
    {"title": "Portable Charger", "icon": "🔋", "desc": "A high-capacity power bank is useful for long flights or layovers."},
    {"title": "Noise-Canceling Headphones", "icon": "🎧", "desc": "Helps reduce travel stress by blocking out noise."},
    {"title": "Offline Maps & Travel Apps", "icon": "🗺️", "desc": "Download maps and apps to navigate without Wi-Fi."},
    {"title": "E-Readers & Entertainment", "icon": "📚", "desc": "Download books, movies, and podcasts before your flight."},
    {"title": "AirTags or Tile Trackers", "icon": "📍", "desc": "Place these in checked baggage to track lost luggage."}
  ];

  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'TECH TIPS',
      subtitle: 'FOR SMART TRAVEL',
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
                      builder: (context) => EfficientPackingTips(),
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