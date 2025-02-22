import 'package:flutter/material.dart';
import 'package:jet_set_go/special_assistance_styling.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class CallingOption extends StatelessWidget {
  const CallingOption ({super.key});

  @override
  Widget build(BuildContext context) {
    return UI(
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
                        height: 600,
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
                                "Call BIA Passenger Service Unit",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Icon(Icons.phone, color: Colors.blue[800], size: 150),
                            const SizedBox(height: 12),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text("The BIA Service Center is located at the BIA premises.Call +94197332382 for guidance and to arrange required assistance.",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.w600
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _launchDialer(context, '0197332382');
                              },
                              icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                              label: Text("Continue", style: TextStyle(fontSize: 20)),
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
        title: Text('Error',style: TextStyle(color: Colors.red),),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Close',style: TextStyle(color: Colors.blue),),
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
