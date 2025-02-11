import 'package:flutter/material.dart';
import 'document_upload_page.dart';

class DocumentSelectionPage extends StatelessWidget{

  const DocumentSelectionPage({super.key});

  void _navigateToUploadPage(BuildContext context, String documentType){
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>DocumentUploadPage(documentType:documentType),
        ),
    );
  }

  Widget _buildDocumentButton(BuildContext context, String documentType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () => _navigateToUploadPage(context, documentType),
        child: Text(documentType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"), // Your background image
          fit: BoxFit.cover, // Ensures full-screen coverage
        ),
      ),

    child:  Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text("Select Document Type")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDocumentButton(context, "Ticket"),
              _buildDocumentButton(context, "NIC"),
              _buildDocumentButton(context, "Passport"),
              _buildDocumentButton(context, "Boarding Pass"),
              _buildDocumentButton(context, "Visa"),
              _buildDocumentButton(context, "Prescriptions"),
              _buildDocumentButton(context, "Other"),
            ],
          ),
        ),
      ),
    );
  }


}