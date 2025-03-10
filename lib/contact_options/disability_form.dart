import 'package:flutter/material.dart';
import 'package:jet_set_go/special_assistance_styling.dart';
import 'package:url_launcher/url_launcher.dart';

class DisabilityForm extends StatelessWidget {
  const DisabilityForm({super.key});

  @override
  Widget build(BuildContext context) {
    return UI(
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
                        height: 450,
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
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),

                            Icon(Icons.file_open_outlined, color: Colors.blue[800], size: 120),
                            const SizedBox(height: 10),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "This form is provided by Sri Lankan Airlines to request assistance.\nPlease note that, this is not available for flights departing in the next 72 hours.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.w600
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
                              label: Text("Continue", style: TextStyle(fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800],
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