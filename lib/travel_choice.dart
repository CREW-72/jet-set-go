// lib/travel_choice_screen.dart
import 'package:flutter/material.dart';
import 'package:jet_set_go/travel_details.dart';


class TravelChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Travel Choice")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Travelling Solo or Family?",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Do nothing for Solo
              },
              child: Text("Solo"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TravelDetails(),
                  ),
                );
              },
              child: Text("Family"),
            ),
          ],
        ),
      ),
    );
  }
}