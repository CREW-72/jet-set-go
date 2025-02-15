import 'package:flutter/material.dart';
import 'document_upload_page.dart';

class DocumentSelectionPage extends StatelessWidget {
  const DocumentSelectionPage({super.key});

  void _navigateToUploadPage(BuildContext context, String documentType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentUploadPage(documentType: documentType),
      ),
    );
  }

  Widget _buildDocumentButton(
      BuildContext context, String documentType, String assetPath,
      {double height = 120, double width = double.infinity}) {
    return GestureDetector(
      onTap: () => _navigateToUploadPage(context, documentType),
      child: Container(
        height: height, // Dynamically adjustable height
        width: width,
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
            Image.asset(assetPath, width: 70, height: 80), // Icon image
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("User's Documents"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 60,left: 20,right: 20),
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
                  height: 140, // Customizable height
                ),
              ),
              SizedBox(height: 10), // Space between ticket button and grid

              // Wrap GridView with Padding to move it up/down
              Padding(
                padding: EdgeInsets.only(top: 10), // Adjust this value to move the grid
                child: SizedBox(
                  height: 500, // Keeps full content visible
                  child: GridView.count(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.4, // Adjusts button height
                    children: [
                      _buildDocumentButton(
                          context, "Passport", "assets/images/passport.png", height: 130),
                      _buildDocumentButton(
                          context, "Boarding Pass", "assets/images/boarding_pass.png", height: 130),
                      _buildDocumentButton(
                          context, "Visa", "assets/images/visa.png", height: 130),
                      _buildDocumentButton(
                          context, "NIC", "assets/images/nic.png", height: 130),
                      _buildDocumentButton(
                          context, "Prescriptions", "assets/images/prescriptions.png", height: 130),
                      _buildDocumentButton(
                          context, "Other", "assets/images/other.png", height: 130),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
