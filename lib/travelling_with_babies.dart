import 'package:flutter/material.dart';
import 'package:jet_set_go/travelling_with_infants_info.dart';
import 'package:jet_set_go/visit_counter.dart';

import 'calling_option.dart';

class TravellingWithBabies extends StatelessWidget {
  const TravellingWithBabies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Travelling with Children" ,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            AssistanceOption(
              icon: Icons.question_mark_rounded,
              text: "What I Should Know About",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TravellingWithInfantsInfo()),
                );
              },
            ),
            SizedBox(height: 50),
            AssistanceOption(
              icon: Icons.phone,
              text: "Call BIA Passenger Service Unit",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => CallingOption()),
                );// Call the function from calling_option.dart
              },
            ),
            SizedBox(height: 50),
            AssistanceOption(
              icon: Icons.info,
              text: "Visit Passenger Service Counter",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => VisitCounter()),
                );// Call the function from visit_counter.dart
              },
            ),
            SizedBox(height: 50),
          ],
        ),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(18),),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 6),
              Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),],
          ),
        ),
      ),
    );
  }
}





