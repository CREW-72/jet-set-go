import 'package:flutter/material.dart';

class UI extends StatelessWidget {
  final Widget body;
  final BottomNavigationBar? bottomNavigationBar;

  const UI({
    required this.body,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BACKGROUND PICTURE WITH BODY
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pageBackground.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: body, // Embedding the body here
          ),
          // Header Image
          Positioned(
            top:0,
            left: 0,right: 0,
            child: Image.asset(
              "assets/images/headerBackground.png",
              height: 126,// Adjust the size as needed
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top:80,
            left: 130,right: 0,
            child: Image.asset(
              "assets/images/takeoff.png",
              height: 50,// Adjust the size as needed
            ),
          ),
          Positioned(
            top:90,
            left: 20,right: 170,
            child: Image.asset(
              "assets/images/Line 1.png",
              height: 50,// Adjust the size as needed
            ),
          ),
          Positioned(
            top: 25,
            left: 20,
            child: Text('AIRPORT', style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 3.0, // Increase the width of the letters
            ),),
          ),
          Positioned(
            top: 85,
            left: 20,
            child: Text('NAVIGATION',style: TextStyle(fontSize: 20,color: Colors.white,letterSpacing: 2.0,),),
          ),
        ],
      ),
    );
  }
}