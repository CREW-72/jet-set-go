import 'package:flutter/material.dart';

class MedicalClearanceInfo extends StatelessWidget {
  const MedicalClearanceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medical Clearance Information",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Divider(color: Colors.white, height: 3), // Add a line after the AppBar
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2)], // Dark to light blue gradient
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 350,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Added padding
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionHeading("Important"),
                            Text("Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.\n",style: TextStyle(fontSize: 18,color: Colors.blue[900],fontWeight: FontWeight.bold),
                            ),
                            Text("To ensure the comfort, safety, and well-being of all passengers on board, passengers with the following conditions or reduced mobility must obtain medical clearance from the Group Medical Officer (CMBIMUL) prior to booking or flying.\n\nThe airline requires medical clearance for any unusual medical conditions disclosed at booking and may consult with the Group Medical Officer before confirming the flight.",
                              style: TextStyle(fontSize: 18,color: Colors.blue[900]),
                            ),
                            SizedBox(height: 24),
                            buildSectionHeading("Conditions Requiring Medical Clearance:"),
                            SizedBox(height: 24),
                            Text("1. Passengers with contagious diseases or conditions that may pose a health risk to others.\n\n 2. Passengers exhibiting unusual behavior or physical conditions that could impact other passengers or crew\n\n3. Passengers needing medical attention (Extra Oxygen) or special equipment during the flight.\n\n4. Passengers with medical conditions that may worsen during the flight.(recent surgeries, heart attacks,strokes)\n\n5. Passengers with mental impairments,Alzheimer’s, Autism or intellectual disabilities.\n\n6. WCHC Passengers:\n\n  • WCHR (R for ramp) - Able to\n    ascend/descend steps and\n    make own way to/from cabin\n    seat but aircraft.\n\n  • WCHS (S for steps)- cannot\n    ascend/descend steps hence\n    must be carried up/down steps\n    but can make own way to/from\n    cabin seat.\n\n  • WCHC (C for cabin seat) -\n    completely immobile.\n\n7. Passengers below 75 years and above 85 years of age who require wheelchair assistance.\n\n8. Passengers needing a stretcher.",
                              style: TextStyle(fontSize: 18, color: Colors.blue[900]),
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
          )
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
        style: TextStyle(
          fontSize: 24,
          color: Colors.blue[900],
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
        color: Colors.blue[900],
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}