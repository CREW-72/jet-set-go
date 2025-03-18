import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/special_assistance/assistance_types/reduced_mobility.dart';
import 'package:jet_set_go/special_assistance/assistance_types/travelling_during_pregnancy.dart';
import 'package:jet_set_go/special_assistance/assistance_types/travelling_with_children.dart';
import 'package:jet_set_go/special_assistance/assistance_types/unaccompanied_minors.dart';
import 'package:jet_set_go/special_assistance/special_assistance_styling.dart';


class SpecialAssistance extends StatelessWidget {
  const SpecialAssistance({super.key});

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
                    const SizedBox(height: 120),
                    Text(
                      "What Type of Special Assistance\n Do You Need?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        textStyle: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
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
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns icons and text properly
              children: [
                Icon(icon, color: Colors.blue[900], size: 40),
                const SizedBox(width: 20), // Equal spacing
                Expanded(
                  child: Text(
                    text,
                    style:  TextStyle(
                      color: Colors.blue[900],
                      fontSize: 16,
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
