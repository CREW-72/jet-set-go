import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';


class calling_option extends StatelessWidget {
  const calling_option ({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor:  Colors.white,
  appBar: AppBar(
  title: Text("Special Assistance",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
  centerTitle: true,
  backgroundColor: Colors.blue,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  ),
  body: Center(
  child: Container(
    width: 350,
  height: 600,
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
  color: Colors.blue,
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
  color: Colors.white,
  fontWeight: FontWeight.bold,
  ),
  textAlign: TextAlign.center,
  ),
  ),
  SizedBox(height: 20),
  Icon(Icons.phone, color: Colors.white, size: 150),
  SizedBox(height: 12),
  Text(
  "The BIA Service Center is located at the BIA premises.Call +94197332382 for guidance and to arrange required assistance.",
  style: TextStyle(
  fontSize: 18,
  color: Colors.white,
  ),
  textAlign: TextAlign.justify,
  ),
  ElevatedButton.icon(
  onPressed: () {
  _launchDialer(context, '+94197332382');
  },
  icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.blue),
  label: Text("Continue", style: TextStyle(fontSize: 20)),
  style: ElevatedButton.styleFrom(
  backgroundColor: Colors.white,
  foregroundColor: Colors.blue,
  minimumSize: Size(200, 50),
  ),
  ),
  ],
  ),
  ),
  ),
  );
  }
}
Future<void> _launchDialer(BuildContext context, String phoneNumber) async {
  final PermissionStatus permissionStatus = await Permission.phone.request();
  if (permissionStatus.isGranted) {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Could not launch $phoneUri');
      _showErrorDialog(context, 'Could not launch dialer. No app available to handle the call.');
    }
  } else {
    print('Phone permission not granted');
    _showErrorDialog(context, 'Phone permission not granted.');
  }
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error',style: TextStyle(color: Colors.red),),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Close',style: TextStyle(color: Colors.blue),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
