import 'package:flutter/material.dart';

class GeneralTips extends StatelessWidget{
  final List<Map<String, String>> tips = [
    {"title": "Pack Light & Smart", "icon": "🎒", "desc": "Stick to versatile outfits that can be mixed and matched."},
    {"title": "Roll, Don’t Fold", "icon": "🌀", "desc": "Rolling clothes saves space and minimizes wrinkles."},
    {"title": "Use Packing Cubes", "icon": "📦", "desc": "Organize clothes by category to save space and easily access items."},
    {"title": "Extra Bag for Dirty Clothes", "icon": "🛍️", "desc": "Keep your luggage organized and fresh."},
    {"title": "Emergency Kit", "icon": "⛑️", "desc": "Include basic medicines, band-aids, and personal hygiene items."},
    {"title": "Backup Copies of Documents", "icon": "📄", "desc": "Store digital and printed copies of passports, visas, and tickets."}
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("General Tips"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: tips.map((tip){
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
    );
  }
}