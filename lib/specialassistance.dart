import 'package:flutter/material.dart';
import 'package:jet_set_go/reducedmobility.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
            SpecialAssistanceCategory(
              icon: Icons.pregnant_woman_rounded,
              title: "Travelling during Pregnancy",
              onTap: () {
                _inProgressMessage(context);
              },
            ),
            SpecialAssistanceCategory(
              icon: Icons.child_care_rounded,
              title: "Travelling with premature babies,\n infants and children",
              onTap: () {
                _inProgressMessage(context);
              },
            ),
            SpecialAssistanceCategory(
              icon: Icons.boy,
              title: "Unaccompanied Minors and Young\n  Passengers",
              onTap: () {
                _inProgressMessage(context);
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
              Icon(icon, color: Colors.white),
              SizedBox(width: 6),
              Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
void  _inProgressMessage(BuildContext context){
  showDialog(context: context, builder:  (BuildContext context){
    return AlertDialog(
      title: Row(
        children: [Icon(
          Icons.construction_outlined,
          color: Colors.amber,
        ),
          SizedBox(width: 8),
          Text(
            "Warning",
            style: TextStyle(
              color: Colors.amber,
              fontFamily: "Arial",
            ),
          ),
        ],
      ),
      content: Text("We are busy making this better for you. \nWe will have it ready soon !",style: TextStyle(fontFamily: "Arial", fontSize: 18),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Close',
            style: TextStyle(
                color: Colors.blue, fontFamily: "Arial", fontSize: 16),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
  );
}
