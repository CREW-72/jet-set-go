import 'package:flutter/material.dart';

class VisitCounter extends StatelessWidget {
  const VisitCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Special Assistance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Visit Passenger Service Counter",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Icon(Icons.info_outline_rounded, color: Colors.white, size: 150),
              SizedBox(height: 12),
              Text(
                'For any special assistance needed ,Visit the Passenger Service Unit located at the BIA premises .\nClick "Continue" and we’ll direct you to the counter.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              ElevatedButton.icon(
                onPressed: () {
                /*  Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalClearanceInfo()),
                  );*/
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

