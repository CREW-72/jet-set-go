import 'package:flutter/material.dart';
import 'package:jet_set_go/medical_clearance_info.dart';
import 'package:url_launcher/url_launcher.dart';
class ReducedMobility extends StatelessWidget {
  const ReducedMobility({super.key});
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
            GestureDetector(
              onTap: (){
                _showWhatShouldKnow(context);
              },
            child:Container(
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
                    Icon(
                      Icons.question_mark_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "What I Should Know",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            ),
            GestureDetector(
              onTap: (){
                _showinfoRequestForm(context);
              },

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
                    Icon(
                      Icons.file_copy,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      " Access Disability Assistance \n Request Form",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),

                  ],
                ),
              ),
            ),
            ),
            GestureDetector(
              onTap: (){
                _showinfoCalling(context);
              },
            child:Container(
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
                    Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Call BIA Passenger Service Unit",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            ),
            GestureDetector(
              onTap: (){
                _showinfoVisitCounter(context);
              },

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
                    Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Visit Passenger Service Counter",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
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

void _showinfoCalling(BuildContext context) {
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


