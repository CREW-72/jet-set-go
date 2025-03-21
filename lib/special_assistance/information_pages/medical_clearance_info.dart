import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalClearanceInfo extends StatelessWidget {
  const MedicalClearanceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medical Clearance Information",
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
                "assets/reduced mobility passenger.jpg",
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
              "To ensure the comfort, safety, and well-being of all passengers on board, passengers with the following conditions or reduced mobility must obtain medical clearance from the Group Medical Officer (CMBIMUL) prior to booking or flying. The airline requires medical clearance for any unusual medical conditions disclosed at booking and may consult with the Group Medical Officer before confirming the flight.",
            ),
            const SizedBox(height: 20),
            buildSectionHeading("Conditions Requiring Medical Clearance"),
            const SizedBox(height: 10),
            buildBulletPoint("Passengers with contagious diseases or conditions that may pose a health risk to others."),
            buildBulletPoint("Passengers exhibiting unusual behavior or physical conditions that could impact other passengers or crew."),
            buildBulletPoint("Passengers needing medical attention (Extra Oxygen) or special equipment during the flight."),
            buildBulletPoint("Passengers with medical conditions that may worsen during the flight (recent surgeries, heart attacks, strokes)."),
            buildBulletPoint("Passengers with mental impairments, Alzheimer’s, Autism, or intellectual disabilities."),
            buildBulletPoint("Passengers requiring a wheelchair:", isBold: true),
            buildSubBulletPoint("WCHR - Can ascend/descend steps and move to/from cabin seat but needs assistance."),
            buildSubBulletPoint("WCHS - Cannot ascend/descend steps and must be carried up/down but can move to/from cabin seat."),
            buildSubBulletPoint("WCHC - Completely immobile and requires full assistance."),
            buildBulletPoint("Passengers below 75 years and above 85 years of age who require wheelchair assistance."),
            buildBulletPoint("Passengers needing a stretcher."),
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

Widget buildBulletPoint(String text, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Icon(Icons.circle, size: 8, color: Colors.blue[900]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.mulish(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.blue[900],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSubBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 24, top: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.circle, size: 6, color: Colors.blueGrey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.mulish(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}