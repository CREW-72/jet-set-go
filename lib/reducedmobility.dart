import 'package:flutter/material.dart';

class reducedmobility extends StatelessWidget {
  const reducedmobility({super.key});
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
            Container(
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
                    SizedBox(
                        width:
                        6),
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      onPressed: () {
                        _showWhatShouldKnow(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
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
                    SizedBox(
                        width:
                        6),
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      onPressed: () {
                        _showinfoRequstForm(
                            context); // Call function to show dialog
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
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
                    SizedBox(
                        width:
                        6),
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      onPressed: () {
                        _showinfoCalling(
                            context); // Call function to show dialog
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
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
                    SizedBox(
                        width:
                        6), // Add some spacing between the text and the dropdown arrow
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      onPressed: () {
                        _showinfoVisitCounter(
                            context); // Call function to show dialog
                      },
                    ),
                  ],
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
          ' 1. Reduced Mobility Passengers require \n     medical clearance from the \n     Group Medical Officer (CMBIMUL).\n\n 2. Wheel Chair Assistance is provided at the \n     BIA for senior citizens of age 75-85 years \n     upon request.',
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

void _showinfoRequstForm(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Disability Assistance Request Form',
            style: TextStyle(color: Colors.blue, fontFamily: "Arial")),
        content: Text(
          'This form is provided by Sri Lankan Airlines to request assistance. Please note, it’s not available for flights departing in the next 72 hours.',
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

