import 'package:flutter/material.dart';
import 'package:jet_set_go/travelling_during_pregnancy_info.dart';
import 'package:jet_set_go/visit_counter.dart';

import 'calling_option.dart';

class TravellingDuringPregnancy extends StatelessWidget {
  const TravellingDuringPregnancy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Travelling during Pregnancy",
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
      body: Column(
          children: [
            const Divider(color: Colors.white,height: 3,), // Add a line after the AppBar
            Expanded(child: Container(
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
                      const Text(
                        "What Type of Special Assistance\n Do You Need?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      SizedBox(height: 20),
                      AssistanceOption(
                        icon: Icons.question_mark_rounded,
                        text: "What I Should Know About",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TravellingDuringPregnancyInfo()),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      AssistanceOption(
                        icon: Icons.phone,
                        text: "Call BIA Passenger Service Unit",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => CallingOption()),
                          );// Call the function from calling_option.dart
                        },
                      ),
                      SizedBox(height: 20),
                      AssistanceOption(
                        icon: Icons.info,
                        text: "Visit Passenger Service Counter",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => VisitCounter()),
                          );// Call the function from visit_counter.dart
                        },
                      ),
                      const SizedBox(height: 20),
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
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns icons and text properly
              children: [
                Icon(icon, color: Colors.blue[900], size: 40),
                const SizedBox(width: 20), // Equal spacing
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
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






