import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnaccompaniedMinorsInfo extends StatelessWidget {
  const UnaccompaniedMinorsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Unaccompanied Minors Info",
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.054),
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
                "assets/unaccompanied minor.webp",
                height: 250,
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
              "1. Children aged 5 to 11 years (up to their 12th birthday) traveling alone are classified as unaccompanied minors.\n\n"
                  "2. Travel conditions:\n\n"
                  "   • Aged 5 and above – Allowed on single-sector flights.\n\n"
                  "   • Aged 6 to 11 – Allowed on multi-sector flights, including interline travel.\n\n"
                  "3. Standard adult fare applies for unaccompanied minors.\n\n"
                  "4. Unaccompanied minor tickets cannot be purchased online.\n\n"
                  "5. Young passengers aged 12 to 15 years (up to their 16th birthday) may receive the same assistance upon request by a parent/guardian.\n\n"
                  "6. Unaccompanied minors and young passengers with a connecting flight will be kept in the lounge until boarding.\n\n"
                  "7. Unaccompanied minors will be handled by the airline from check-in until the child is handed over to the designated persons on arrival.\n\n"
                  "8. Passengers aged 12 to 17 cannot accompany a younger child alone unless an adult (18 years or older) is present.\n\n"
                  "9. Parents/guardians must complete all necessary documentation.\n\n"
                  "10. Parents/guardians will receive a UM/YP Traveling Alone (UM/YPTA) folder along with the ticket.\n\n"
                  "11. Passengers must arrive at least 2 hours before departure for check-in.\n\n"
                  "12. Parents/guardians must stay at the airport until the flight departs in case of disruptions.",
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
