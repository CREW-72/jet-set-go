import 'package:flutter/material.dart';

class TravellingDuringPregnancyInfo extends StatelessWidget {
  const TravellingDuringPregnancyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Traveling During Pregnancy",
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
              height: 1100,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  buildSectionHeading("Important"),
                  Text(
                    "Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.\n",
                    style: TextStyle(fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "1.Expectant mothers are advised to consult a doctor regarding their fitness to fly before booking a ticket.\n\n2.Pregnant passengers beyond 28 weeks must present a Medical Certificate, issued within seven days of travel, confirming an uncomplicated pregnancy and fitness to fly.\n\n3.Travel is permitted based on flight duration:\n\n  • Up to 4 hours: Single pregnancy up to 36 weeks, multiple/complicated pregnancy up to 32 weeks.\n\n  • Over 4 hours: Single pregnancy up to 35 weeks, multiple/complicated pregnancy up to 28 weeks.\n\n5.Failure to present a valid Medical Certificate may result in denied boarding.\n\n6.Air travel is not recommended within seven days post-delivery.",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),

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
