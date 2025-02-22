import 'package:flutter/material.dart';
import 'package:jet_set_go/special_assistance_styling.dart';

class MedicalClearanceInfo extends StatelessWidget {
  const MedicalClearanceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return UI(
      body: Column(
        children: [
          Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      Container(
                        width: 350,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Added padding
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.85),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionHeading("Reduced Mobility Passengers"),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                                child: Image.asset(
                                  "assets/reduced mobility passenger.jpg",
                                  height: 300, // Adjust the size as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text("Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.\n",style: TextStyle(fontSize: 18,color: Colors.blue[800],fontWeight: FontWeight.bold),
                            ),
                            Text("To ensure the comfort, safety, and well-being of all passengers on board, passengers with the following conditions or reduced mobility must obtain medical clearance from the Group Medical Officer (CMBIMUL) prior to booking or flying.\n\nThe airline requires medical clearance for any unusual medical conditions disclosed at booking and may consult with the Group Medical Officer before confirming the flight.",
                              style: TextStyle(fontSize: 18,color: Colors.blue[800],fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 24),
                            buildSectionHeading("Conditions Requiring Medical Clearance:"),
                            SizedBox(height: 24),
                            Text("1. Passengers with contagious diseases or conditions that may pose a health risk to others.\n\n 2. Passengers exhibiting unusual behavior or physical conditions that could impact other passengers or crew\n\n3. Passengers needing medical attention (Extra Oxygen) or special equipment during the flight.\n\n4. Passengers with medical conditions that may worsen during the flight.(recent surgeries, heart attacks,strokes)\n\n5. Passengers with mental impairments,Alzheimer’s, Autism or intellectual disabilities.\n\n6. WCHC Passengers:\n\n  • WCHR (R for ramp) - Able to\n    ascend/descend steps and\n    make own way to/from cabin\n    seat but aircraft.\n\n  • WCHS (S for steps)- cannot\n    ascend/descend steps hence\n    must be carried up/down steps\n    but can make own way to/from\n    cabin seat.\n\n  • WCHC (C for cabin seat) -\n    completely immobile.\n\n7. Passengers below 75 years and above 85 years of age who require wheelchair assistance.\n\n8. Passengers needing a stretcher.",
                              style: TextStyle(fontSize: 18, color: Colors.blue[800],fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget buildSectionHeading(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 26,
          color: Colors.blue[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildText(String text, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.blue[800],
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}