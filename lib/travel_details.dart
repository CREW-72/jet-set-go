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
              "Is there any Children travelling with you?",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 450),
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