import 'package:flutter/material.dart';
import 'package:jet_set_go/calling_option.dart';
import 'package:jet_set_go/reducedMobility_info.dart';
import 'package:jet_set_go/visit_counter.dart';
import 'disability_form.dart';
class ReducedMobility extends StatelessWidget {
  const ReducedMobility({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reduced Mobility Passengers",
          style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold
          ),
        ),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AssistanceOption(
              icon: Icons.question_mark_rounded,
              text: "What I Should Know",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => reducedMobility_info()),
                );
              },
            ),
            AssistanceOption(
              icon: Icons.file_copy,
              text: "Access Disability Assistance \n Request Form",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => disability_form()),
                );
              },
            ),
            AssistanceOption(
              icon: Icons.phone,
              text: "Call BIA Passenger Service Unit",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => calling_option()),
                );// Call the function from calling_option.dart
              },
            ),
            AssistanceOption(
              icon: Icons.info,
              text: "Visit Passenger Service Counter",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => visit_counter()),
                );// Call the function from visit_counter.dart
              },
            ),
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 6),
              Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}






