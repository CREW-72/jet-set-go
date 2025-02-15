import 'package:flutter/material.dart';
class UnaccompaniedMinorsInfo extends StatelessWidget {
  const UnaccompaniedMinorsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Unaccompanied Minors",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
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
              height: 1900,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.blue[900],borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  buildSectionHeading("Important"),
                  Text("Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.\n",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  Text("1. Children aged 5 to 11 years (up to their 12th birthday) traveling alone are classified as unaccompanied minors.\n\n"
                      "2. Travel conditions:\n\n"
                      "  • Aged 5 and above – Allowed on\n    single-sector flights.\n\n"
                      "  • Aged 6 to 11 – Allowed on\n     multi-sector flights, including\n    interline travel.\n\n"
                      "3. Standard adult fare applies for unaccompanied minors.\n\n"
                      "4. Unaccompanied minor tickets cannot be purchased online.\n\n"
                      "5. Young passengers aged 12 to 15 years (up to their 16th birthday) may receive the same assistance upon request by a parent/guardian.\n\n"
                      "6. Unaccompanied minors and young passengers with a connecting flight will be kept in the lounge until boarding.\n\n"
                      "7. Unaccompanied minors will be handled by the airline from the point of check-in until the child is handed over to the designated persons meeting the child on arrival at the destination.\n\n"
                      "8. Passengers aged 12 to 17 cannot accompany a younger child alone unless an adult (18 years or older) is present.\n\n"
                      "9. Parents/guardians must complete all necessary documentation.\n\n"
                      "10. Parents/guardians will receive a UM/YP Traveling Alone (UM/YPTA) folder along with the ticket.\n\n"
                      "11. Passengers must arrive at least 2 hours before departure for check-in.\n\n"
                      "12. Parents/guardians must stay at the airport until the flight departs in case of disruptions.\n\n"
                    ,style: TextStyle(fontSize: 20,color: Colors.white),),
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