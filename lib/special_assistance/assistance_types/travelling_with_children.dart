import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // New style import

import '../contact_options/calling_option.dart';
import '../contact_options/visit_counter.dart';
import '../information_pages/travelling_with_children_info.dart';

class TravellingWithChildren extends StatelessWidget {
  const TravellingWithChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'FAMILY',
      subtitle: 'ASSISTANCE',
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
                    AssistanceOption(
                      icon: Icons.question_mark_rounded,
                      text: "What I Should Know About",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TravellingWithChildrenInfo()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
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
                Icon(icon, color: Colors.blue[900], size: 40),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
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