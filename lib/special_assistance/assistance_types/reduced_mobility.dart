import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // New style import
import '../contact_options/calling_option.dart';
import '../contact_options/disability_form.dart';
import '../contact_options/visit_counter.dart';
import '../information_pages/medical_clearance_info.dart';

class ReducedMobility extends StatelessWidget {
  const ReducedMobility({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return UI(
      title: "MOBILITY",
      subtitle: "ASSISTANCE",
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
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
                    AssistanceOption(
                      icon: Icons.question_mark_rounded,
                      text: "What I Should Know About",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MedicalClearanceInfo()),
                        );
                      },
                    ),
                    AssistanceOption(
                      icon: Icons.file_copy,
                      text: "Access Disability Assistance \n Request Form",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DisabilityForm()),
                        );
                      },
                    ),
                    AssistanceOption(
                      icon: Icons.phone,
                      text: "Call BIA Passenger Service Unit",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CallingOption()),
                        );
                      },
                    ),
                    AssistanceOption(
                      icon: Icons.info,
                      text: "Visit Passenger Service Counter",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VisitCounter()),
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),
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

class AssistanceOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const AssistanceOption({
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
            color: Color.fromRGBO(255, 255, 255, 0.85),
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