import 'package:flutter/material.dart';
import 'package:jet_set_go/reducedmobility.dart';
import 'package:jet_set_go/travelling_during_pregnancy.dart';
import 'package:jet_set_go/travelling_with_babies.dart';
import 'package:jet_set_go/unaccompanied_minors.dart';

class SpecialAssistance extends StatelessWidget {
  const SpecialAssistance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Special Assistance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            SpecialAssistanceCategory(
              icon: Icons.assist_walker,
              title: "Reduced Mobility Passengers",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReducedMobility()),
                );
              },
            ),
            SizedBox(height: 50),

            SpecialAssistanceCategory(
              icon: Icons.pregnant_woman_rounded,
              title: "Travelling during Pregnancy",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => travelling_during_pregnancy()),
                );
              },
            ),
            SizedBox(height: 50),

            SpecialAssistanceCategory(
              icon: Icons.child_friendly,
              title: "Travelling with  infants",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => travelling_with_babies()),
                );
              },
            ),
            SizedBox(height: 50),

            SpecialAssistanceCategory(
              icon: Icons.boy,
              title: "Unaccompanied Minors",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => unaccompanied_minors()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class SpecialAssistanceCategory extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SpecialAssistanceCategory({
    required this.icon,
    required this.title,
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
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              SizedBox(width: 6),
              Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
