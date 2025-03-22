import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TravellingWithChildrenInfo extends StatelessWidget {
  const TravellingWithChildrenInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Travelling With Children",
          style: GoogleFonts.mulish(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.054),
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
                "assets/travelling with children.webp",
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
              "1. Children (Ages 2-11 years) cannot travel alone and must be accompanied by an adult.\n\n"
                  "2. Infants (Under 2 years) must be accompanied by an adult when booking online and do not have separate seats and must be seated on an adult’s lap.\n\n"
                  "3. Infants must be at least 7 days old to travel.\n\n"
                  "4. If One adult is traveling with two infants, an additional seat must be purchased at a child fare.\n\n"
                  "5. Infant baggage allowance: 10 kg.\n\n"
                  "6. Carrycot/baby stroller is allowed if there is space in the cabin; otherwise, it must be checked in.\n\n"
                  "7. A bassinet (sky cot) is a small bed for infants, provided on a first-come, first-served basis. Check at check-in if a bassinet is reserved and available.\n\n"
                  "8. Bassinet eligibility criteria:\n\n"
                  "  • Infant must not be able to sit unassisted.\n\n"
                  "  • Maximum weight limit: 16 kg.\n\n"
                  "  • Infant must fit inside the bassinet (size: 24” X 12” X 8”).\n\n"
                  "  • Infant must be secured using bassinet restraints.\n\n"
                  "9. If an infant is born premature or has medical complications, a Medical Form must be submitted.\n\n"
                  "10. Infants under 7 days old may only travel for medical emergencies (in incubators) or compassionate reasons.",
            ),
            const SizedBox(height: 24),
            buildSectionHeading("Escort requirements for medical cases:"),
            buildText(
              "  • Normal healthy babies (7 days - 2 years): No medical clearance required, must be accompanied by mother or escort.\n\n"
                  "  • Newborns under 7 days old: Medical clearance required, must be accompanied by mother or suitable escort (e.g., nurse).\n\n"
                  "  • Premature babies or those with complications: Medical clearance required, must be accompanied by a qualified doctor, medical nurse, or attendant.",
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
