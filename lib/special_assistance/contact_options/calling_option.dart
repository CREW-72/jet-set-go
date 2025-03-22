import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // New style import
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class CallingOption extends StatelessWidget {
  const CallingOption({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return UI(
      title: "Special",
      subtitle: "Assistance",
      body: Column(
        children: [
          const Divider(color: Colors.white, height: 3),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 110),
                    Container(
                      width: 350,
                      height: 550, // Slightly increased height for balance
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.9).withAlpha(230), // Slightly opaque
                        borderRadius: BorderRadius.circular(20), // Softened corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(51),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // Position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Call BIA Passenger Service Unit",
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                  fontSize: screenWidth * 0.069,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Icon(Icons.phone, color: Colors.blue[900], size: 100), // Reduced size for balance
                          const SizedBox(height: 10),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "The BIA Service Center is located at the BIA premises. Call +94197332382 for guidance and to arrange required assistance.",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20), // Added spacing
                          ElevatedButton.icon(
                            onPressed: () {
                              _launchDialer(context, '0197332382');
                            },
                            icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                            label: Text(
                              "Continue",
                              style: GoogleFonts.lobster(
                                textStyle: TextStyle(fontSize: 22, color: Colors.white),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              minimumSize: Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Rounded button
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12), // Better button padding
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchDialer(BuildContext context, String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      logger.e('Could not launch $phoneUri');
      if (context.mounted) {
        _showErrorDialog(context, 'Could not launch dialer. No app available to handle the call.');
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: Colors.red),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}