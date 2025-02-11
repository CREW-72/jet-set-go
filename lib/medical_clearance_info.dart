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
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Container(
              width: 350,
              height: 2000,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  buildSectionHeading("Important"),
                  Text("Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.\n",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  Text("To ensure the comfort, safety, and well-being of all passengers on board, passengers with the following conditions or reduced mobility must obtain medical clearance from the Group Medical Officer (CMBIMUL) prior to booking or flying.\n\nThe airline requires medical clearance for any unusual medical conditions disclosed at booking and may consult with the Group Medical Officer before confirming the flight.",
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  SizedBox(height: 24),
                  buildSectionHeading("Conditions Requiring Medical Clearance:"),
                  SizedBox(height: 24),
                  Text("1. Passengers with contagious diseases or conditions that may pose a health risk to others.\n\n 2. Passengers exhibiting unusual behavior or physical conditions that could impact other passengers or crew\n\n3. Passengers needing medical attention (Extra Oxygen) or special equipment during the flight.\n\n4. Passengers with medical conditions that may worsen during the flight.(recent surgeries, heart attacks,strokes)\n\n5. Passengers with mental impairments,Alzheimer’s, Autism or intellectual disabilities.\n\n6. WCHC Passengers:\n\n• WCHR (R for ramp) - Able to ascend/descend steps and make own way to/from cabin seat but aircraft.\n\n• WCHS (S for steps)- cannot ascend/descend steps hence must be carried up/down steps but can make own way to/from cabin seat.\n\n• WCHC (C for cabin seat) - completely immobile.\n\n7. Passengers below 75 years and above 85 years of age who require wheelchair assistance.\n\n8. Passengers needing a stretcher.",
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  SizedBox(height: 20),
                ],
              ),
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
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
  }
