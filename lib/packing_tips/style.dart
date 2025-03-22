import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../homepages/homepage_registered_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jet_set_go/authentication/welcome_screen.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
            top: screenHeight * 0.119,
            right: screenWidth * 0.3,
            child: Image.asset(
              "assets/plane.png",
              height: 50, // Adjust the size as needed
            ),
          ),
          Positioned(
            top: screenHeight * 0.140,
            left: 24,
            right: 170,
            child: Image.asset(
              "assets/images/line.png",
              height: 50, // Adjust the size as needed
            ),
          ),
          Positioned(
            top: screenHeight * 0.065,
            left: 24,
            child: Text(
              title,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 3.0, // Increase the width of the letters
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.13,
            left: 24,
            child: Text(
              subtitle,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.065,
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
                  case 'Sign Out':
                    _signOutAndRedirect(context);
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  _buildMenuItem(Icons.home, 'Home'),
                  _buildMenuItem(Icons.settings, 'Settings'),
                  _buildMenuItem(Icons.lightbulb, 'Features'),
                  _buildMenuItem(Icons.person, 'Profile'),
                  _buildMenuItem(Icons.logout, 'Sign out'),

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
          Icon(icon, color: Colors.black54),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  void _signOutAndRedirect(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
    );
  }
}