import 'package:flutter/material.dart';
import 'package:jet_set_go/special_assistance_styling.dart';

class UnaccompaniedMinorsInfo extends StatelessWidget {
  const UnaccompaniedMinorsInfo({super.key});

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
                            buildSectionHeading("Unaccompanied Minors"),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                                child: Image.asset(
                                  "assets/unaccompanied minor.webp",
                                  height: 300, // Adjust the size as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                            SizedBox(height: 15),
                            Text("Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.", style: TextStyle(fontSize: 18,color: Colors.blue[800],fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            buildText(
                              "1. Children aged 5 to 11 years (up to their 12th birthday) traveling alone are classified as unaccompanied minors.\n\n"
                                  "2. Travel conditions:\n\n"
                                  "   • Aged 5 and above – Allowed on\n    single-sector flights.\n\n"
                                  "   • Aged 6 to 11 – Allowed on\n    multi-sector flights, including\n    interline travel.\n\n"
                                  "3. Standard adult fare applies for unaccompanied minors.\n\n"
                                  "4. Unaccompanied minor tickets cannot be purchased online.\n\n"
                                  "5. Young passengers aged 12 to 15 years (up to their 16th birthday) may receive the same assistance upon request by a parent/guardian.\n\n"
                                  "6. Unaccompanied minors and young passengers with a connecting flight will be kept in the lounge until boarding.\n\n"
                                  "7. Unaccompanied minors will be handled by the airline from check-in until the child is handed over to the designated persons on arrival.\n\n"
                                  "8. Passengers aged 12 to 17 cannot accompany a younger child alone unless an adult (18 years or older) is present.\n\n"
                                  "9. Parents/guardians must complete all necessary documentation.\n\n"
                                  "10. Parents/guardians will receive a UM/YP Traveling Alone (UM/YPTA) folder along with the ticket.\n\n"
                                  "11. Passengers must arrive at least 2 hours before departure for check-in.\n\n"
                                  "12. Parents/guardians must stay at the airport until the flight departs in case of disruptions.\n\n",
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
        style: TextStyle(
          fontSize: 24,
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
          fontWeight: FontWeight.w500
      ),
    ),
  );
}