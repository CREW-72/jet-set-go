import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisabilityForm extends StatelessWidget {
  const DisabilityForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Special Assistance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Divider(color: Colors.white, height: 3),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 350,
                        height: 600,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
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
                                  fontSize: 24,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Icon(Icons.file_open_outlined, color: Colors.blue[900], size: 150),
                            const SizedBox(height: 12),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "This form is provided by Sri Lankan Airlines to request assistance.\nPlease note that, this is not available for flights departing in the next 72 hours.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue[900],
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
                              label: Text("Continue", style: TextStyle(fontSize: 20)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
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