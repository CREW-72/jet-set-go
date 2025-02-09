import 'package:flutter/material.dart';

class WeatherBasedTips extends StatelessWidget{
  final List<Map<String, String>> tips = [
    {"title": "Check Destination Weather", "icon": "🌍", "desc": "Pack accordingly—warm layers for cold climates, light clothing for tropical destinations."},
    {"title": "Rain or Snow Preparedness", "icon": "☔", "desc": "Carry a compact umbrella or waterproof jacket to stay dry."},
    {"title": "Sun Protection", "icon": "🌞", "desc": "Pack sunscreen, sunglasses, and a hat for sunny destinations."},
    {"title": "Layering Strategy", "icon": "🧥", "desc": "Opt for layers instead of heavy clothing for better temperature control."},
    {"title": "Footwear Choices", "icon": "👟", "desc": "Waterproof boots for cold/wet areas; breathable shoes for hot regions."}
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Weather Tips"),
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