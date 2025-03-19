import 'package:flutter/material.dart';
import 'dart:async';
import 'package:jet_set_go/authentication/welcome_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds, then navigate to WelcomeScreen
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/sky.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SizedBox(
              height: 400,  // Keeps the exact same height
              width: 400,   // Keeps the exact same width
              child: Image.asset('assets/images/loading.gif', fit: BoxFit.contain),
            ),
          ),
          // Logo at the bottom (NO CHANGES)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: 200, // Keeps the exact same height
                width: 250,  // Keeps the exact same width
                child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
