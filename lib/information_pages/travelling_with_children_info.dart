import 'package:flutter/material.dart';
import 'package:jet_set_go/special_assistance_styling.dart';

class TravellingWithInfantsInfo extends StatelessWidget {
  const TravellingWithInfantsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return  UI(
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
                            buildSectionHeading("Travelling With Children"),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                                child: Image.asset(
                                  "assets/travelling with children.webp",
                                  height: 300, // Adjust the size as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                            SizedBox(height: 15,),
                            Text("Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.\n",style: TextStyle(fontSize: 18,color: Colors.blue[800],fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "1. Children (Ages 2-11 years) cannot travel alone and must be accompanied by an adult.\n\n"
                                  "2. Infants (Under 2 years) must be accompanied by an adult when booking online and do not have separate seats and must be seated on an adult’s lap.\n\n"
                                  "3. Infants must be at least 7 days old to travel.\n\n"
                                  "4. If One adult is traveling with two infants, an additional seat must be purchased at a child fare.\n\n"
                                  "5. Infant baggage allowance: 10 kg.\n\n"
                                  "6. Carrycot/baby stroller is allowed if there is space in the cabin; otherwise, it must be checked in.\n\n"
                                  "7. A bassinet (sky cot) is a small bed for infants, provided on a first-come, first-served basis. Check at check-in if a bassinet is reserved and available.\n\n"
                                  "8. Bassinet eligibility criteria:\n\n"
                                  "  • Infant must not be able to sit\n    unassisted.\n\n"
                                  "  • Maximum weight limit: 16 kg.\n\n"
                                  "  • Infant must fit inside the bassinet\n    (size: 24” X 12” X 8”).\n\n"
                                  "  • Infant must be secured using\n    bassinet restraints.\n\n"
                                  "9. If an infant is born premature or has medical complications, a Medical Form must be submitted.\n\n"
                                  "10. Infants under 7 days old may only travel for medical emergencies (in incubators) or compassionate reasons."
                              ,style: TextStyle(fontSize: 18,color: Colors.blue[800],fontWeight: FontWeight.w500),),
                            SizedBox(height: 24),
                            buildSectionHeading("Escort requirements for medical cases:"),
                            Text("  • Normal healthy babies\n    (7 days - 2 years): No medical\n    clearance required, must be\n    accompanied by mother or escort.\n\n"
                                "  • Newborns under 7 days old:\n    Medical clearance required, must\n    be accompanied by mother or\n    suitable escort (e.g., nurse).\n\n"
                                "  • Premature babies or those with\n    complications: Medical clearance\n    required, must be accompanied by\n    a qualified doctor, medical nurse,\n    or attendant.\n\n"
                                ,style: TextStyle(fontSize: 18,color: Colors.blue[800],fontWeight: FontWeight.w500),),




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