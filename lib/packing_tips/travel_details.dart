import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/security_based_tips.dart';
import 'package:jet_set_go/packing_tips/style.dart';
import 'packing_selection_screen.dart';

class TravelDetails extends StatelessWidget {
  const TravelDetails({super.key});

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
              color: Color.fromRGBO(255, 255, 255, 0.9), // Soft white background
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
                  "Are There Any Children Traveling With You?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    textStyle: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Subtitle with softer tone
                Text(
                  "Let’s make sure you have the best packing tips for your family trip!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 30),
                // Buttons for Yes and No selection
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
                        icon: Icon(Icons.close, color: Colors.white),
                        label: Text(
                          "NO",
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
                              builder: (context) => PackingSelectionScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.check, color: Colors.white),
                        label: Text(
                          "YES",
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
