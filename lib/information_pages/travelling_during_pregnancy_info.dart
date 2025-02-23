import 'package:flutter/material.dart';
import 'package:jet_set_go/special_assistance_styling.dart';

class TravellingDuringPregnancyInfo extends StatelessWidget {
  const TravellingDuringPregnancyInfo({super.key});

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
                            buildSectionHeading("Travelling during Pregnancy"),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                                child: Image.asset(
                                  "assets/pregnant passenger.jpg",
                                  height: 300, // Adjust the size as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                            SizedBox(height: 15,),
                            Text(
                              "Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.\n",
                              style: TextStyle(fontSize: 18,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "1. Expectant mothers are advised to consult a doctor regarding their fitness to fly before booking a ticket.\n\n2. Pregnant passengers beyond 28 weeks must present a Medical Certificate, issued within seven days of travel, confirming an uncomplicated pregnancy and fitness to fly.\n\n3. Travel is permitted based on flight duration:\n\n  • Up to 4 hours: Single pregnancy up\n    to 36 weeks, multiple/complicated\n    pregnancy up to 32 weeks.\n\n  • Over 4 hours: Single pregnancy up\n    to 35 weeks, multiple/complicated\n    pregnancy up to 28 weeks.\n\n4. Failure to present a valid Medical Certificate may result in denied boarding.\n\n5. Air travel is not recommended within seven days post-delivery.",
                              style: TextStyle(fontSize: 18, color: Colors.blue[800],fontWeight:  FontWeight.w500),
                            ),


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
        fontWeight: FontWeight.bold
      ),
    ),
  );
}