// lib/tips_display_screen.dart
import 'package:flutter/material.dart';
import 'package:jet_set_go/security_based_tips.dart';


class TipsDisplayScreen extends StatelessWidget {
  final List<String> selectedCategories;

  TipsDisplayScreen(this.selectedCategories);

  final Map<String, List<Map<String, String>>> tips = {
    "Toddlers (0-3 years)": [
      {"title": "Diaper Bag Must-Haves", "icon": "🍼", "desc": "Pack diapers, wipes, rash cream, and a changing pad—plus extras!"},
      {"title": "Baby Food & Bottles", "icon": "🥤", "desc": "Keep formula, snacks, and bottles easily accessible."},
      {"title": "Comfort First", "icon": "🧸", "desc": "Bring a pacifier, teething toy, or favorite blanket."},
      {"title": "Hands-Free Travel", "icon": "👜", "desc": "A baby carrier is easier than a stroller, especially at security checks."},
      {"title": "Mess-Free Hydration", "icon": "🥤", "desc": "A spill-proof sipping cup and bibs help keep things clean and stress-free."},
      {"title": "Extra Clothes, Just in Case", "icon": "👕", "desc": "Accidents happen! Keep two extra outfits in your hand luggage for quick changes."},
      {"title": "Weather-Ready", "icon": "☀️", "desc": "Pack a light blanket, stroller rain cover, and baby sunscreen for any climate."},
      {"title": "Mini First-Aid Kit", "icon": "💊", "desc": "Include infant pain relievers, a thermometer, band-aids, and any needed meds."},
      {"title": "Keep Them Entertained", "icon": "📖", "desc": "Small interactive toys and books help pass the time without making a mess."}
    ],
    "Young Children (4-10 years)": [
      {"title": "Little Explorer’s Backpack", "icon": "🎒", "desc": "Let kids carry their own snacks, a toy, and a water bottle for a sense of independence."},
      {"title": "Fun on the Go", "icon": "🎨", "desc": "Pack coloring books, stickers, travel board games, or a tablet with kid-friendly content."},
      {"title": "Comfy Travel Outfit", "icon": "👕", "desc": "Choose soft, breathable clothes and easy slip-on shoes for stress-free dressing."},
      {"title": "Smart Snacking", "icon": "🍎", "desc": "Bring healthy snacks and a reusable water bottle to avoid pricey airport food."},
      {"title": "Safety First", "icon": "🆘", "desc": "Use an emergency contact wristband with parent/guardian details in case of separation."},
      {"title": "Pre-Trip Talk", "icon": "🗣️", "desc": "Explain airport security procedures to help reduce anxiety before the trip."},
      {"title": "Quiet & Calm", "icon": "🎧", "desc": "Noise-canceling headphones can block out loud airplane sounds and keep them relaxed."},
      {"title": "Spill-Proof Strategy", "icon": "🧳", "desc": "Pack an extra outfit and ziplock bags for spills or motion sickness."},
      {"title": "Kid-Friendly Packing", "icon": "📦", "desc": "Use packing cubes to help them organize clothes easily."},
      {"title": "Encourage Independence", "icon": "🌟", "desc": "Let kids help pack and plan to make them feel involved and excited!"}
    ],
    "Teenagers (11+ years)": [
      {"title": "Pack Your Own Carry-On", "icon": "🎒", "desc": "Teens should be in charge of their backpack with essentials like a charger, headphones, and snacks."},
      {"title": "Travel Light & Smart", "icon": "🧳", "desc": "Choose mix-and-match outfits to avoid overpacking."},
      {"title": "Stay Connected", "icon": "📍", "desc": "Download offline maps and travel apps for easy navigation."},
      {"title": "Power Up on the Go", "icon": "🔋", "desc": "A portable power bank is a must to keep devices charged."},
      {"title": "Block Out the Noise", "icon": "🎧", "desc": "Noise-canceling headphones help with sleep and focus on long flights."},
      {"title": "Go Digital", "icon": "📱", "desc": "Save passports, tickets, and IDs on your phone for easy access."},
      {"title": "Dress for Comfort", "icon": "👟", "desc": "Wear layers and comfy walking shoes for long travel days."},
      {"title": "Share Essentials", "icon": "🛁", "desc": "If traveling with family, share toiletries to save space."},
      {"title": "Capture the Journey", "icon": "📖", "desc": "A travel journal is a fun way to document memories."},
      {"title": "Snack Smart", "icon": "🥜", "desc": "Pack protein bars, nuts, and dried fruit to avoid unhealthy airport food."}
    ],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: selectedCategories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Packing Tips"),
          bottom: TabBar(
            isScrollable: true,
            tabs: selectedCategories.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: selectedCategories.map((category) {
                  return ListView(
                    padding: EdgeInsets.all(10),
                    children: tips[category]!.map((tip) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Text(tip["icon"]!, style: TextStyle(fontSize: 24)),
                          title: Text(tip["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(tip["desc"]!),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
            Padding(
            padding: const EdgeInsets.all( 30.0),
            child: SizedBox(
              width: 300,
              height: 45,
              child:ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecurityBasedTips(),
                  ),
                );
              },
              icon: Icon(Icons.arrow_forward),
              label: Text("Next"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
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
      ),
    );
  }
}