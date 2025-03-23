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
          Positioned.fill(
            child: Image.asset(
              'assets/images/sky.png',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset('assets/images/loading.gif', fit: BoxFit.contain),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
