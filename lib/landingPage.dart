import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';

class Landingpage extends StatelessWidget {
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
              height: 400,  // Increased height
              width: 400,   // Increased width
              child: Image.asset('assets/images/loading.gif', fit: BoxFit.contain),
            ),
          ),
          // Logo at the bottom
          Positioned(
            bottom: 0, // Keep the position at the bottom
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: 200, // Increased size
                width: 250,  // Optional width
                child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
