import 'package:flutter/material.dart';
import 'package:jet_set_go/tech_tips.dart';

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
      appBar: AppBar(title: Text("General Tips"),),
      body: Column(
        children: [
          Expanded(
            child: ListView(
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
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child:SizedBox(
              width: 300,
              height: 45,
              child:ElevatedButton.icon(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TechTips()
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
    );
  }
}