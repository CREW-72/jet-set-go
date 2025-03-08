import 'package:flutter/material.dart';
import 'package:jet_set_go/security_based_tips.dart';
import 'package:jet_set_go/style.dart';
import 'package:jet_set_go/travel_details.dart';

class TravelChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'LUGGAGE',
      subtitle: 'PACKING TIPS',
      //appBar: AppBar(title: Text("Travel Choice")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,

          children: [
            Center(
              child: Text(
                "Travelling Solo or With Family?",
                style: TextStyle(fontSize: 24,
                color: Colors.white),
              ),
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecurityBasedTips(),
                      ),
                    );
                  },
                  icon: Icon(Icons.person, color: Colors.white),
                  label: Text(
                    "Solo",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(140, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TravelDetails(),
                      ),
                    );
                  },
                  icon: Icon(Icons.family_restroom, color: Colors.white),
                  label: Text(
                    "Family",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(140, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}