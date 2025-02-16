import 'package:flutter/material.dart';

class TravellingDuringPregnancyInfo extends StatelessWidget {
  const TravellingDuringPregnancyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Traveling During Pregnancy",
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
                            Center(child: Text("️ℹ️",style: TextStyle(fontSize: 96))),
                            Text(
                              "Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.\n",
                              style: TextStyle(fontSize: 18,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "1. Expectant mothers are advised to consult a doctor regarding their fitness to fly before booking a ticket.\n\n2. Pregnant passengers beyond 28 weeks must present a Medical Certificate, issued within seven days of travel, confirming an uncomplicated pregnancy and fitness to fly.\n\n3. Travel is permitted based on flight duration:\n\n  • Up to 4 hours: Single pregnancy up\n    to 36 weeks, multiple/complicated\n    pregnancy up to 32 weeks.\n\n  • Over 4 hours: Single pregnancy up\n    to 35 weeks, multiple/complicated\n    pregnancy up to 28 weeks.\n\n4. Failure to present a valid Medical Certificate may result in denied boarding.\n\n5. Air travel is not recommended within seven days post-delivery.",
                              style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                            ),


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