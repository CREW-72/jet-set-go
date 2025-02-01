import 'package:flutter/material.dart';

class MedicalClearanceInfo extends StatelessWidget {
  const MedicalClearanceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medical Clearance Information",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Text(
              "To ensure the comfort, safety, and well-being of all passengers on board, passengers with the following conditions or reduced mobility must obtain medical clearance from the Group Medical Officer (CMBIMUL) prior to booking or flying.",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24),
            buildSectionHeading("Conditions Requiring Medical Clearance:"),
            buildSectionText(
                "1. Passengers with contagious diseases or conditions that may pose a health risk to others."),
            buildSectionText(
                "2. Passengers exhibiting unusual behavior or physical conditions that could impact other passengers or crew."),
            buildSectionText(
                "3. Passengers needing medical attention (Extra Oxygen) or special equipment during the flight."),
            buildSectionText(
                "4. Passengers with medical conditions that may worsen during the flight.(recent surgeries, heart attacks,strokes)"),
            buildSectionText(
                "5. Passengers with mental impairments,Alzheimer’s, Autism or intellectual disabilities."),
            buildSectionText(
                "6. WCHC Passengers:"),
            buildSectionText("• WCHR (R for ramp) - Able to ascend/descend steps and make own way to/from cabin seat but aircraft."),
            buildSectionText("• WCHS (S for steps)- cannot ascend/descend steps hence must be carried up/down steps but can make own way to/from cabin seat."),
            buildSectionText("• WCHC (C for cabin seat) - completely immobile."),
            buildSectionText(
                "7. Passengers below 75 years and above 85 years of age who require wheelchair assistance."),
            buildSectionText("8. Passengers needing a stretcher."),
            SizedBox(height: 20),
            buildSectionHeading("Note:"),
            Text(
              "The airline requires medical clearance for any unusual medical conditions disclosed at booking and may consult with the Group Medical Officer before confirming the flight.",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget buildSectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
