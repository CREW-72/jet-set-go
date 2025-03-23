import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // New style import
import 'package:url_launcher/url_launcher.dart';

class DisabilityForm extends StatelessWidget {
  const DisabilityForm({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return UI(
      title: "Special",
      subtitle: "Assistance",
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 110),
                    Container(
                      width: 350,
                      height: 550,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.85),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Disability Assistance Request Form",
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
                          Icon(Icons.file_open_outlined, color: Colors.blue[900], size: 120),
                          const SizedBox(height: 10),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "This form is provided by Sri Lankan Airlines to request assistance.\nPlease note that, this is not available for flights departing in the next 72 hours.",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _launchFormURL();
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

  void _launchFormURL() async {
    const formUrl = 'https://www.srilankan.com/en_uk/flying-with-us/disability-assistance-request';
    final uriForm = Uri.parse(formUrl);
    if (await canLaunchUrl(uriForm)) {
      await launchUrl(uriForm);
    } else {
      throw 'Could not launch url';
    }
  }
}