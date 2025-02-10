import 'package:flutter/material.dart';
import 'package:jet_set_go/medical_clearance_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
class ReducedMobility extends StatelessWidget {
  const ReducedMobility({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reduced Mobility Passengers",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AssistanceOption(
              icon: Icons.question_mark_rounded,
              text: "What I Should Know",
              onTap: () {
                _showWhatShouldKnow(context);
              },
            ),
            AssistanceOption(
              icon: Icons.file_copy,
              text: "Access Disability Assistance \n Request Form",
              onTap: () {
                _showinfoRequestForm(context);
              },
            ),
            AssistanceOption(
              icon: Icons.phone,
              text: "Call BIA Passenger Service Unit",
              onTap: () {
                _showInfoCalling(context); // Call the function from calling_option.dart
              },
            ),
            AssistanceOption(
              icon: Icons.info,
              text: "Visit Passenger Service Counter",
              onTap: () {
                _showinfoVisitCounter(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showWhatShouldKnow(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('What I should know ? ',
            style: TextStyle(color: Colors.blue, fontFamily: "Arial")),
        content: Text(
          '1. Reduced Mobility Passengers require medical clearance from the Group Medical Officer (CMBIMUL).\n\n2. Wheel Chair Assistance is provided at the BIA for senior citizens of age 75-85 years upon request.',
          style: TextStyle(fontFamily: "Arial", fontSize: 18),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Learn More',
              style: TextStyle(
                  color: Colors.blue, fontFamily: "Arial", fontSize: 16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedicalClearanceInfo()),
              );
            },
          ),
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(
                  color: Colors.blue, fontFamily: "Arial", fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
class AssistanceOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const AssistanceOption({
    required this.icon,
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 6),
              Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

void _showinfoRequestForm(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Disability Assistance Request Form',
            style: TextStyle(color: Colors.blue, fontFamily: "Arial")),
        content: Text(
          'This form is provided by Sri Lankan Airlines to request assistance.\nPlease note that ,this is not available for flights departing in the next 72 hours.',
          style: TextStyle(fontFamily: "Arial", fontSize: 18),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Continue',
              style: TextStyle(
                  color: Colors.blue, fontFamily: "Arial", fontSize: 16),
            ),
            onPressed: () {
              _launchFormURL();
            },
          ),
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(
                  color: Colors.blue, fontFamily: "Arial", fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showInfoCalling(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Call BIA Passenger Service Unit",
            style: TextStyle(color: Colors.blue, fontFamily: "Arial")),
        content: Text(
          "The BIA Service Center is located at the BIA premises.Call +94197332382 for guidance and to arrange required assistance.",
          style: TextStyle(fontFamily: "Arial", fontSize: 18),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Continue',
              style: TextStyle(
                  color: Colors.blue, fontFamily: "Arial", fontSize: 16),
            ),
            onPressed: () {
            _launchDialer(context, '+94197332382'); // Call BIA Passenger Service Unit  number
            },
          ),
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(
                  color: Colors.blue, fontFamily: "Arial", fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showinfoVisitCounter(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Visit Passenger Service Counter",
            style: TextStyle(color: Colors.blue, fontFamily: "Arial")),
        content: Text(
          "For any special assistance needed ,Visit the Passenger Service Unit located at the BIA premises .\nClick 'Continue' and we’ll direct you to the counter.",
          style: TextStyle(fontFamily: "Arial", fontSize: 18),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Continue',
              style: TextStyle(
                  color: Colors.blue, fontFamily: "Arial", fontSize: 16),
            ),
            onPressed: () {
              //Navigator.of(context).push();
            },
          ),
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(
                  color: Colors.blue, fontFamily: "Arial", fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void _launchFormURL() async{
  const formUrl = 'https://www.srilankan.com/en_uk/flying-with-us/disability-assistance-request';
  final uriForm =Uri.parse(formUrl);
  if(await canLaunchUrl(uriForm)) {
    await launchUrl(uriForm);
  }else{
    throw 'Could not launch url' ;
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





