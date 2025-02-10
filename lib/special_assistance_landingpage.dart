import 'package:flutter/material.dart';
import 'package:jet_set_go/specialassistance.dart';

class SpecialAssistanceLandingPage extends StatelessWidget {
  const SpecialAssistanceLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        title: Text("Special Assistance",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 600,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Receive Guidance \nOn\n Special Assistance",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Icon(Icons.wheelchair_pickup_sharp, color: Colors.white, size: 250),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpecialAssistance()),
                  );
                },
                icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.blue),
                label: Text("Continue", style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  minimumSize: Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
