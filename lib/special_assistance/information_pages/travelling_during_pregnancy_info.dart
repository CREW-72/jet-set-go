import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TravellingDuringPregnancyInfo extends StatelessWidget {
  const TravellingDuringPregnancyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Travelling During Pregnancy",
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1C263F),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/pregnant passenger.jpg",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            buildText(
              "Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.",
              isItalic: true,
            ),
            buildText(
              "1. Expectant mothers are advised to consult a doctor regarding their fitness to fly before booking a ticket.",
            ),
            buildText(
              "2. Pregnant passengers beyond 28 weeks must present a Medical Certificate, issued within seven days of travel, confirming an uncomplicated pregnancy and fitness to fly.",
            ),
            buildText(
              "3. Travel is permitted based on flight duration:\n\n  • Up to 4 hours: Single pregnancy up to 36 weeks, multiple/complicated pregnancy up to 32 weeks.\n\n  • Over 4 hours: Single pregnancy up to 35 weeks, multiple/complicated pregnancy up to 28 weeks.",
            ),
            buildText(
              "4. Failure to present a valid Medical Certificate may result in denied boarding.",
            ),
            buildText(
              "5. Air travel is not recommended within seven days post-delivery.",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

Widget buildSectionHeading(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.mulish(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.blue[900],
      ),
    ),
  );
}

Widget buildText(String text, {bool isItalic = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 16,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        color: Colors.black87,
      ),
      textAlign: TextAlign.justify,
    ),
  );
}
