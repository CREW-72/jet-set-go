import 'package:flutter/material.dart';

class VisitCounter extends StatelessWidget {
  const VisitCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Special Assistance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Divider(color: Colors.white, height: 3),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 350,
                        height: 600,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
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
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Icon(Icons.info_outline_rounded, color: Colors.blue[900], size: 150),
                            const SizedBox(height: 12),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "For any special assistance needed, Visit the Passenger Service Unit located at the BIA premises .\nClick 'Continue' and we’ll direct you to the counter.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue[900],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                /* insert page */
                              },
                              icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                              label: Text("Continue", style: TextStyle(fontSize: 20)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
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
          ),
        ],
      ),
    );
  }
}