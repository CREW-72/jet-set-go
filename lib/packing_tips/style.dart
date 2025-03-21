import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../homepages/homepage_registered_user.dart';

class UI extends StatelessWidget {
  final Widget body;
  final String title;
  final String subtitle;

  const UI({
    required this.body,
    required this.title,
    required this.subtitle,
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
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: body, // Embedding the body here
          ),
          // Header Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/header.jpg",
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 104,
            left: 145,
            right: 0,
            child: Image.asset(
              "assets/plane.png",
              height: 50, // Adjust the size as needed
            ),
          ),
          Positioned(
            top: 118,
            left: 24,
            right: 170,
            child: Image.asset(
              "assets/line.jpg",
              height: 50, // Adjust the size as needed
            ),
          ),
          Positioned(
            top: 60,
            left: 24,
            child: Text(
              title,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 3.0, // Increase the width of the letters
                ),
              ),
            ),
          ),
          Positioned(
            top: 107,
            left: 24,
            child: Text(
              subtitle,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 15,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.menu, color: Colors.white, size: 40),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: Offset(0, 50),
              onSelected: (value) {
                switch (value) {
                  case 'Home':
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePageRegistered()),
                    );
                    break;
                  case 'Settings':
                    Navigator.pushNamed(context, '/settings');
                    break;
                  case 'Features':
                    Navigator.pushNamed(context, '/features');
                    break;
                  case 'Profile':
                    Navigator.pushNamed(context, '/profile');
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  _buildMenuItem(Icons.home, 'Home'),
                  _buildMenuItem(Icons.settings, 'Settings'),
                  _buildMenuItem(Icons.lightbulb, 'Features'),
                  _buildMenuItem(Icons.person, 'Profile'),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(IconData icon, String text) {
    return PopupMenuItem<String>(
      value: text,
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}