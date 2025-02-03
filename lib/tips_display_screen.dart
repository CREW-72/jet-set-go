// lib/tips_display_screen.dart
import 'package:flutter/material.dart';

class TipsDisplayScreen extends StatelessWidget {
  final List<String> selectedCategories;

  TipsDisplayScreen(this.selectedCategories);

  final Map<String, List<Map<String, String>>> tips = {
    "Toddlers (0-3 years)": [
      {"title": "Diaper Bag Must-Haves", "icon": "🍼", "desc": "Pack diapers, wipes, rash cream, and a changing pad—plus extras!"},
      {"title": "Baby Food & Bottles", "icon": "🥤", "desc": "Keep formula, snacks, and bottles easily accessible."},
      {"title": "Comfort First", "icon": "🧸", "desc": "Bring a pacifier, teething toy, or favorite blanket."},
    ],
    "Young Children (4-10 years)": [
      {"title": "Little Explorer’s Backpack", "icon": "🎒", "desc": "Let kids carry their own essentials."},
      {"title": "Fun on the Go", "icon": "🎨", "desc": "Bring coloring books, travel games, and a tablet with content."},
      {"title": "Safety First", "icon": "🛡", "desc": "Use an emergency contact wristband with guardian details."},
    ],
    "Teenagers (11+ years)": [
      {"title": "Pack Your Own Carry-On", "icon": "🎧", "desc": "Teens should carry their essentials like charger and snacks."},
      {"title": "Stay Connected", "icon": "📱", "desc": "Download offline maps and travel apps for easy navigation."},
      {"title": "Snack Smart", "icon": "🍫", "desc": "Pack protein bars, nuts, and dried fruit."},
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
        body: TabBarView(
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
    );
  }
}