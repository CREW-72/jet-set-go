import 'package:flutter/material.dart';
import 'document_upload_page.dart';

class DocumentSelectionPage extends StatefulWidget {
  const DocumentSelectionPage({super.key});

  @override
  _DocumentSelectionPageState createState() => _DocumentSelectionPageState();
}

class _DocumentSelectionPageState extends State<DocumentSelectionPage> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Add navigation functionality if required
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/home'); // Navigate to Home Page
          break;
        case 1:
          Navigator.pushNamed(context, '/settings'); // Navigate to Settings
          break;
        case 2:
          Navigator.pushNamed(context, '/features'); // Navigate to Features Page
          break;
        case 3:
          Navigator.pushNamed(context, '/profile'); // Navigate to Profile Page
          break;
      }
    });
  }

  void _navigateToUploadPage(BuildContext context, String documentType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentUploadPage(documentType: documentType),
      ),
    );
  }
  Widget _buildAirTicketButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToUploadPage(context, "Air Ticket"),
      child: Container(
        height: 140, // Button height
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
            image: AssetImage("assets/images/plane_pattern.png"), // Your plane pattern image
            fit: BoxFit.cover, // Cover the entire button
            opacity: 0.5, // Adjust this value to control transparency
          ),
        ),
        child: Stack(
          children: [
            // Move Image to the Left Corner
            Positioned(
              left: -20, // Aligns to the left edge
              top: -20, // Adjust this to move it up/down
              child: Image.asset(
                "assets/images/ticket.png",
                width: 200, // Adjust width for a bigger icon
                height: 200, // Adjust height
                fit: BoxFit.contain,
              ),
            ),

            // Air Ticket Text
            Positioned(
              left: 150, // Moves text to the right, adjust as needed
              top: 50, // Center text vertically
              child: Text(
                "Air Ticket",
                style: TextStyle(
                  fontSize: 30,
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
    return GestureDetector(
      onTap: () => _navigateToUploadPage(context, documentType),
      child: Container(
        height: 130, // Uniform height for all buttons
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFA5E5FF),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
          image: DecorationImage(
            image: AssetImage("assets/images/plane_pattern.png"), // Your plane pattern image
            fit: BoxFit.cover, // Cover the entire button
            opacity: 0.5, // Adjust this value to control transparency
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, width: 100, height: 100), // Icon image
            SizedBox(height: 10),
            Text(
              documentType,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

          // HEADER SECTION (Copied from Transport Page)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/images/header.png", height: 160, fit: BoxFit.cover),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              'USER\'S',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3.0,
              ),
            ),
          ),
          Positioned(
            top: 113,
            left: 24,
            child: Text(
              'DOCUMENTS',
              style: TextStyle(fontSize: 20, color: Colors.white, letterSpacing: 2.0),
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            right: 120,
            child: Image.asset("assets/images/line.png", height: 8, fit: BoxFit.cover),
          ),
          Positioned(
            top: 100,
            right: 70,
            child: Image.asset("assets/images/plane_takeoff.png", height: 50),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // CONTENT SECTION BELOW HEADER
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
            child: Column(
              children: [
                // Air Ticket Button (No changes here)
                SizedBox(
                  width: double.infinity,
                  child: _buildAirTicketButton(context),
                ),

                // Grid Section Moved Up
                Transform.translate(
                  offset: Offset(0, -45),  // Moves GridView UP
                  child: SizedBox(
                    height: 500,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5, // Adjust for closer button spacing
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.3,
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
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        backgroundColor: Colors.blue[900],
        selectedItemColor: Color(0xFFACE6FC),
        unselectedItemColor: Color(0xFFACE6FC),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.home)), label: ''),
          BottomNavigationBarItem(icon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.settings)), label: ''),
          BottomNavigationBarItem(icon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.lightbulb)), label: ''),
          BottomNavigationBarItem(icon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.person)), label: ''),
        ],
      ),
    );
  }
}