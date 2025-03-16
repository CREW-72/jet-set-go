import 'package:flutter/material.dart';
import 'package:jet_set_go/special_assistance/special_assistance_styling.dart';

class VisitCounter extends StatelessWidget {
  const VisitCounter({super.key});

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
                      const SizedBox(height: 110),
                      Container(
                        width: 350,
                        height: 400,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.85),
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
                                  fontSize: 18,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Icon(Icons.info_outline_rounded, color: Colors.blue[800], size: 120),
                            const SizedBox(height: 10),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "For any special assistance needed, Visit the Passenger Service Unit located at the BIA premises .\nClick 'Continue' and we’ll direct you to the counter.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.w600
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _inProgressMessage(context);
                              },
                              icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                              label: Text("Continue", style: TextStyle(fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800],
                                foregroundColor: Colors.white,
                                minimumSize: Size(200, 50),
                              ),
                            ),
                          ],
                        ),
                      ),
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
void  _inProgressMessage(BuildContext context){
  showDialog(context: context, builder:  (BuildContext context){
    return AlertDialog(
      title: Row(
        children: [

          Text(
            "⚠️ Warning",
            style: TextStyle(fontSize: 18,color: Colors.blue[800], fontFamily: "Arial", fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
      content: Text("We are busy making this better for you. \nWe will have it ready soon !",style: TextStyle(fontSize: 18,
        color: Colors.blue[800],
        fontWeight: FontWeight.w600
      ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Close',
            style: TextStyle(
                color: Colors.blue[800], fontFamily: "Arial", fontSize: 16),
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