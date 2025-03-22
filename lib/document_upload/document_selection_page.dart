import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './document_upload_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/homepages/homepage_registered_user.dart';

class DocumentSelectionPage extends StatefulWidget {
  const DocumentSelectionPage({super.key});

  @override
  DocumentSelectionPageState createState() => DocumentSelectionPageState();
}

class DocumentSelectionPageState extends State<DocumentSelectionPage> {
  String username = "User"; // Default username

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  void _navigateToUploadPage(BuildContext context, String documentType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentUploadPage(documentType: documentType),
      ),
    );
  }

  Future<void> _fetchUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc.data() != null) {
          setState(() {
            username = userDoc['username'] ?? "User"; // Fetch username or default
          });
        }
      } catch (e) {
        throw Exception("Error fetching username: $e");
      }
    }
  }

  Widget _buildAirTicketButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToUploadPage(context, "Air Ticket"),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFA5E5FF),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              spreadRadius: 1,
              offset: Offset(2, 3),
            ),
          ],
          image: DecorationImage(
            image: AssetImage("assets/images/plane_pattern.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -20,
              top: -20,
              child: Image.asset(
                "assets/images/ticket.png",
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),

            // Air Ticket Text
            Positioned(
              left: 150,
              top: 50,
              child: Text(
                "Air Ticket",
                style: GoogleFonts.ubuntu(
                  fontSize: MediaQuery.of(context).size.width * 0.065,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDocumentButton(
      BuildContext context, String documentType, String assetPath) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => _navigateToUploadPage(context, documentType),
      child: Container(
        height: screenHeight * 0.20,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFA5E5FF),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
          image: const DecorationImage(
            image: AssetImage("assets/images/plane_pattern.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              width: screenWidth * 0.18,
              height: screenWidth * 0.18,
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              documentType,
              style: GoogleFonts.ubuntu(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }


  PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),


          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/images/header.png", height: 160, fit: BoxFit.cover),
          ),
          Positioned(
            top: screenHeight * 0.065,
            left: 20,
            child: Text(
              '${username.toUpperCase()}’S',
              style: GoogleFonts.ubuntu(
                fontSize: screenWidth * 0.11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.14,
            left: 24,
            child: Text(
              'DOCUMENTS',
              style: GoogleFonts.ubuntu(
                  fontSize: screenWidth * 0.05,
                  color: Colors.white, letterSpacing: 2.0),
            ),
          ),
          Positioned(
            top: screenHeight * 0.19,
            left: 20,
            right: 120,
            child: Image.asset("assets/images/line.png", height: 8, fit: BoxFit.cover),
          ),
          Positioned(
            top: screenHeight * 0.125,
            right: screenWidth * 0.18,
            child: Image.asset("assets/images/plane_takeoff.png", height: 50),
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



          Positioned(
            top: screenHeight * 0.26,
            left: 20,
            right: 20,
            bottom: screenHeight * 0.02,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.25,
                      child: _buildAirTicketButton(context),
                    ),

                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 8),
                        childAspectRatio: 1.5,
                        children: [
                          _buildDocumentButton(context, "Passport", "assets/images/passport.png"),
                          _buildDocumentButton(context, "Boarding Pass", "assets/images/boarding_pass.png"),
                          _buildDocumentButton(context, "Visa", "assets/images/visa.png"),
                          _buildDocumentButton(context, "NIC", "assets/images/nic.png"),
                          _buildDocumentButton(context, "Prescriptions", "assets/images/prescriptions.png"),
                          _buildDocumentButton(context, "Other", "assets/images/other.png"),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )
          ),
        ],
      ),
    );
  }
}