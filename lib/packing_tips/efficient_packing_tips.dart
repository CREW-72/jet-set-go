import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/landing_page.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // Import the UI class

class EfficientPackingTips extends StatelessWidget {
  EfficientPackingTips({super.key});

  final List<Map<String, String>> tips = [
    {"title": "Limit Shoes to Three Pairs", "icon": "👟", "desc": "Pack a casual pair, a formal pair, and comfortable travel shoes."},
    {"title": "Use Compression Bags", "icon": "🧳", "desc": "Save space for bulky items like jackets by using compression bags."},
    {"title": "Multi-Purpose Items", "icon": "🧣", "desc": "Bring a scarf that doubles as a blanket or a jacket with multiple pockets."},
    {"title": "Wear Heavy Items", "icon": "🧥", "desc": "Wear jackets, boots, and sweaters to save luggage space."},
    {"title": "Plan Outfits in Advance", "icon": "📅", "desc": "Avoid overpacking by pre-planning daily outfits."},
    {"title": "Mini Toiletries & Solid Alternatives", "icon": "🧼", "desc": "Use solid shampoo, conditioner, and soap to avoid liquid restrictions."}
  ];

  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'PACKING TIPS',
      subtitle: 'FOR EFFICIENCY',
      body: Column(
        children: [
          SizedBox(height: 130),
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
            padding: const EdgeInsets.only(bottom: 40.0),
            child: SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LandingPage(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                label: Text(
                    "Finish",
                style: GoogleFonts.lobster(
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
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