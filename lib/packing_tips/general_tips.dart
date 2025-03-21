import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/style.dart';
import 'package:jet_set_go/packing_tips/tech_tips.dart'; // Import the UI class

class GeneralTips extends StatelessWidget {
  GeneralTips({super.key});
  final List<Map<String, String>> tips = [
    {"title": "Pack Light", "icon": "🧳", "desc": "Only bring essentials to avoid heavy luggage."},
    {"title": "Stay Organized", "icon": "📦", "desc": "Use packing cubes to keep your items sorted."},
    {"title": "First Aid Kit", "icon": "💊", "desc": "Carry a small kit with basic medications and bandages."},
    {"title": "Travel Insurance", "icon": "🛡️", "desc": "Ensure you have coverage for emergencies."},
    {"title": "Copies of Documents", "icon": "📄", "desc": "Keep digital and physical copies of important documents."},
    {"title": "Local Currency", "icon": "💵", "desc": "Have some local currency for small purchases."},
    {"title": "Comfortable Shoes", "icon": "👟", "desc": "Wear shoes suitable for walking long distances."},
    {"title": "Reusable Water Bottle", "icon": "🚰", "desc": "Stay hydrated and reduce plastic waste."},
    {"title": "Snacks", "icon": "🍎", "desc": "Bring healthy snacks for long journeys."},
    {"title": "Portable Charger", "icon": "🔋", "desc": "Keep your devices charged on the go."}
  ];

  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'GENERAL TIPS',
      subtitle: 'FOR TRAVELERS',
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
                      builder: (context) => TechTips(),
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