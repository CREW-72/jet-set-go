import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../homepages/homepage_registered_user.dart';
import 'assistance_types/special_assistance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jet_set_go/authentication/welcome_screen.dart';

class SpecialAssistanceLandingPage extends StatelessWidget {
  const SpecialAssistanceLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/special assistance backdrop.jpg', // Replace with a relevant image
            fit: BoxFit.cover,
          ),

          // Brighter Gradient Overlay for Better Contrast
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(200, 200, 200, 0.8), // Lighter overlay
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50), // Adjust this value to move text lower

                  // Animated Title
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 800),
                    builder: (context, double opacity, child) {
                      return Opacity(opacity: opacity, child: child);
                    },
                    child: Text(
                      " Receive Guidance  \n On  \n Special Assistance ",
                      style: GoogleFonts.caveat(
                        fontSize: screenWidth * 0.099,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Improved contrast
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.45), // Adds space between text and button

                  // Glassmorphic Container
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        // Animated Button
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 900),
                          builder: (context, double scale, child) {
                            return Transform.scale(scale: scale, child: child);
                          },
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpecialAssistance(),
                                ),
                              );
                            },
                            icon: Icon(Icons.flight_takeoff_rounded, color: Colors.white),
                            label: Text(
                              "Continue",
                              style: GoogleFonts.lobster(
                                textStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                              foregroundColor: Colors.white,
                              minimumSize: Size(220, 55),
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              shadowColor: Color.fromRGBO(0, 0, 255, 0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Popup Menu Button
          Positioned(
            top: screenHeight * 0.055,
            right: 11,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.menu, color: Colors.black, size: 40),
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
                  _buildMenuItem(Icons.logout, 'Sign Out'),
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
