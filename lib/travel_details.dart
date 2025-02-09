// lib/travel_details_screen.dart
import 'package:flutter/material.dart';
import 'package:jet_set_go/security_based_tips.dart';
import 'packing_selection_screen.dart';

class TravelDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Travel Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How many Seats have you booked?",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Number of Seats",
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Is there any Children travelling with you?",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackingSelectionScreen(),
                  ),
                );
              },
              child: Text("Yes"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecurityBasedTips(),
                  ),
                );
              },
              child: Text("No"),
            ),
          ],
        ),
      ),
    );
  }
}