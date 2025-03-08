// lib/packing_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:jet_set_go/style.dart';
import 'tips_display_screen.dart';

class PackingSelectionScreen extends StatefulWidget {
  @override
  _PackingSelectionScreenState createState() => _PackingSelectionScreenState();
}

class _PackingSelectionScreenState extends State<PackingSelectionScreen> {
  List<String> selectedCategories = [];

  final List<Map<String, dynamic>> categories = [
    {"title": "Toddlers (0-3 years)", "icon": Icons.baby_changing_station},
    {"title": "Young Children (4-10 years)", "icon": Icons.child_care},
    {"title": "Teenagers (11+ years)", "icon": Icons.boy},
  ];

  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'LUGGAGE',
      subtitle: 'PACKING TIPS',
      //appBar: AppBar(title: Text("Select Age Groups")),
      body: Column(
        children: [
          SizedBox(height:100),
          Expanded(
            child: ListView(
              children: categories.map((category) {
                return CheckboxListTile(
                  title: Text(category["title"] ,style: TextStyle(fontSize:20,color: Colors.white),),
                  secondary: Icon(category["icon"]),
                  value: selectedCategories.contains(category["title"]),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedCategories.add(category["title"]);
                      } else {
                        selectedCategories.remove(category["title"]);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:  50.0),
            child: SizedBox(
              width: 300,
              height: 45,
              child:ElevatedButton(
            onPressed: () {
              if (selectedCategories.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TipsDisplayScreen(selectedCategories),
                  ),
                );
              }
            },
            child: Text("View Tips"),
                style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
          ),
          ),
          ),
          ),
        ],
      ),
    );
  }
}