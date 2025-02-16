import 'package:flutter/material.dart';

class UnaccompaniedMinorsInfo extends StatelessWidget {
  const UnaccompaniedMinorsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Unaccompanied Minors",
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
                          color: Color.fromRGBO(255, 255, 255, 0.85),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionHeading("Important"),
                            Center(child: Text("️ℹ️",style: TextStyle(fontSize: 96))),
                            buildText("Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.", isBold: true),
                            const SizedBox(height: 10),
                            buildText(
                              "1. Children aged 5 to 11 years (up to their 12th birthday) traveling alone are classified as unaccompanied minors.\n\n"
                                  "2. Travel conditions:\n\n"
                                  "   • Aged 5 and above – Allowed on single-sector flights.\n\n"
                                  "   • Aged 6 to 11 – Allowed on multi-sector flights, including interline travel.\n\n"
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