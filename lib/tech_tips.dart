import 'package:flutter/material.dart';
import 'package:jet_set_go/efficient_packing_tips.dart';

class TechTips extends StatelessWidget{
  final List<Map<String, String>> tips = [
    {"title": "Universal Adapter", "icon": "🔌", "desc": "Ensure compatibility with different country power sockets."},
    {"title": "Portable Charger", "icon": "🔋", "desc": "A high-capacity power bank is useful for long flights or layovers."},
    {"title": "Noise-Canceling Headphones", "icon": "🎧", "desc": "Helps reduce travel stress by blocking out noise."},
    {"title": "Offline Maps & Travel Apps", "icon": "🗺️", "desc": "Download maps and apps to navigate without Wi-Fi."},
    {"title": "E-Readers & Entertainment", "icon": "📚", "desc": "Download books, movies, and podcasts before your flight."},
    {"title": "AirTags or Tile Trackers", "icon": "📍", "desc": "Place these in checked baggage to track lost luggage."}
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Tech Tips"),),
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
          ElevatedButton.icon(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EfficientPackingTips(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back),
            label: Text("Back"),
          ),
        ],
      ),
    );
  }
}