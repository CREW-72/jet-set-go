import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/special_assistance/assistance_types/reduced_mobility.dart';
import 'package:jet_set_go/special_assistance/assistance_types/travelling_during_pregnancy.dart';
import 'package:jet_set_go/special_assistance/assistance_types/travelling_with_children.dart';
import 'package:jet_set_go/special_assistance/assistance_types/unaccompanied_minors.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // New style import

class SpecialAssistance extends StatelessWidget {
  const SpecialAssistance({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return UI(
      title: "Special",
      subtitle: "Assistance",
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.25),
            Text(
              "What Type of Special Assistance\n Do You Need?",
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            SpecialAssistanceCategory(
              icon: Icons.accessible,
              text: "Reduced Mobility Passengers",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReducedMobility()),
                );
              },
            ),
            SpecialAssistanceCategory(
              icon: Icons.pregnant_woman_rounded,
              text: "Travelling During Pregnancy",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TravellingDuringPregnancy()),
                );
              },
            ),
            SpecialAssistanceCategory(
              icon: Icons.child_friendly,
              text: "Travelling with Children",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TravellingWithChildren()),
                );
              },
            ),
            SpecialAssistanceCategory(
              icon: Icons.person,
              text: "Unaccompanied Minors",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnaccompaniedMinors()),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}

class SpecialAssistanceCategory extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const SpecialAssistanceCategory({
    required this.icon,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.blue[900], size: screenWidth * 0.1),
                SizedBox(width: screenWidth * 0.05),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}