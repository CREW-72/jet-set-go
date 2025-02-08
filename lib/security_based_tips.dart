// lib/multi_tips_screen.dart
import 'package:flutter/material.dart';

class SecurityBasedTips extends StatelessWidget {
  final Map<String, List<Map<String, String>>> tips = {
    "Security Regulations": [
      {"title": "Diaper Bag Must-Haves", "icon": "🍼", "desc": "Pack diapers, wipes, rash cream, and a changing pad—plus extras!"},
      {"title": "Baby Food & Bottles", "icon": "🥤", "desc": "Keep formula, snacks, and bottles easily accessible."},
    ],
    "Baggage Policy": [
      {"title": "Little Explorer’s Backpack", "icon": "🎒", "desc": "Let kids carry their own essentials."},
      {"title": "Fun on the Go", "icon": "🎨", "desc": "Bring coloring books, travel games, and a tablet with content."},
    ],
    "Hand Luggage Restrictions": [
      {"title": "Pack Your Own Carry-On", "icon": "🎧", "desc": "Teens should carry their essentials like charger and snacks."},
      {"title": "Stay Connected", "icon": "📱", "desc": "Download offline maps and travel apps for easy navigation."},
    ],
    "Important Security Guidelines": [
      {"title": "Travel Light", "icon": "🧳", "desc": "Pack only what you need to avoid heavy luggage."},
      {"title": "Stay Hydrated", "icon": "💧", "desc": "Carry a reusable water bottle to stay hydrated."},
    ],
    "Prohibited Items": [
      {"title": "Comfortable Shoes", "icon": "👟", "desc": "Wear comfortable shoes for long walks."},
      {"title": "Medication", "icon": "💊", "desc": "Keep your medication in your carry-on bag."},
    ],
    "Baggage Interlining": [
      {"title": "Pet Carrier", "icon": "🐾", "desc": "Use a comfortable pet carrier for your pet."},
      {"title": "Pet Food", "icon": "🍖", "desc": "Pack enough pet food for the trip."},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tips.keys.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Multi Tips"),
          bottom: TabBar(
            isScrollable: true,
            tabs: tips.keys.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: TabBarView(
          children: tips.keys.map((category) {
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
    );
  }
}