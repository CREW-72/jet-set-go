import 'package:flutter/material.dart';
import 'package:jet_set_go/packing_tips/security_based_tips.dart';
import 'package:jet_set_go/packing_tips/style.dart';
import 'package:jet_set_go/packing_tips/travel_details.dart';
import 'package:google_fonts/google_fonts.dart';

class TravelChoice extends StatelessWidget {
  const TravelChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'LUGGAGE',
      subtitle: 'PACKING TIPS',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.9), // Slightly increased opacity for readability
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Attractive Heading
                Text(
                  "Who’s Joining Your Journey?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    textStyle: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // Subtitle with softer tone
                Text(
                  "Flying solo or bringing the whole crew? Let’s tailor your travel experience!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 40),
                // Buttons for Solo and Family selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
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
                          style: GoogleFonts.lobster(
                            textStyle: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          minimumSize: Size(140, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
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
                          style: GoogleFonts.lobster(
                            textStyle: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          minimumSize: Size(140, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
