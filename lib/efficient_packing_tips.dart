import 'package:flutter/material.dart';

class EfficientPackingTips extends StatelessWidget{
  final List<Map<String, String>> tips = [
    {"title": "Limit Shoes to Three Pairs", "icon": "👟", "desc": "Pack a casual pair, a formal pair, and comfortable travel shoes."},
    {"title": "Use Compression Bags", "icon": "🧳", "desc": "Save space for bulky items like jackets by using compression bags."},
    {"title": "Multi-Purpose Items", "icon": "🧣", "desc": "Bring a scarf that doubles as a blanket or a jacket with multiple pockets."},
    {"title": "Wear Heavy Items", "icon": "🧥", "desc": "Wear jackets, boots, and sweaters to save luggage space."},
    {"title": "Plan Outfits in Advance", "icon": "📅", "desc": "Avoid overpacking by pre-planning daily outfits."},
    {"title": "Mini Toiletries & Solid Alternatives", "icon": "🧼", "desc": "Use solid shampoo, conditioner, and soap to avoid liquid restrictions."}
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Efficient Packing Tips"),
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