import 'package:flutter/material.dart';
import 'package:jet_set_go/security_based_tips.dart';
import 'package:jet_set_go/style.dart';
import 'packing_selection_screen.dart';

class TravelDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'LUGGAGE',
      subtitle: 'PACKING TIPS',
      //appBar: AppBar(title: Text("Travel Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Ensure horizontal centering
          children: [
            Center(
              child: Text(
                "Are there any Children travelling with you?",
                style: TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center, // Center text horizontally
              ),
            ),
            SizedBox(height: 100), // Adjusted for more balanced spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PackingSelectionScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.check, color: Colors.white),
                  label: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white), // Change text color here
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(160, 50),
                  ),
                ),
                SizedBox(width: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecurityBasedTips(),
                      ),
                    );
                  },
                  icon: Icon(Icons.close, color: Colors.white),
                  label: Text(
                    "No",
                    style: TextStyle(color: Colors.white), // Change text color here
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    minimumSize: Size(160, 50),
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
