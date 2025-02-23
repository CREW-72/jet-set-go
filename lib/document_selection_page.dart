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

  Widget _buildDocumentButton(
      BuildContext context, String documentType, String assetPath) {
    return GestureDetector(
      onTap: () => _navigateToUploadPage(context, documentType),
      child: Container(
        height: 130, // Uniform height for all buttons
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, width: 100, height: 100), // Icon image
            SizedBox(height: 10),
            Text(
              documentType,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Select Document Type"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 10), // Top spacing

              // Air Ticket Button (Full Width)
              SizedBox(
                width: double.infinity,
                child: _buildDocumentButton(
                  context,
                  "Air Ticket",
                  "assets/images/ticket.png",
                ),
              ),
              SizedBox(height: 20), // Space between ticket button and grid

              // Grid layout for the other six buttons
              SizedBox(
                height: 500, // Adjust this value to move the grid up/down
                child: GridView.count(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3, // Adjusts button height
                  children: [
                    _buildDocumentButton(
                        context, "Passport", "assets/images/passport.png"),
                    _buildDocumentButton(
                        context, "Boarding Pass", "assets/images/boarding_pass.png"),
                    _buildDocumentButton(
                        context, "Visa", "assets/images/visa.png"),
                    _buildDocumentButton(
                        context, "NIC", "assets/images/nic.png"),
                    _buildDocumentButton(
                        context, "Prescriptions", "assets/images/prescriptions.png"),
                    _buildDocumentButton(
                        context, "Other", "assets/images/other.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar (Copied from HomePage)
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
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.home),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.settings),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.lightbulb),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.person),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}