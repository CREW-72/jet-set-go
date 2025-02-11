import 'package:flutter/material.dart';
class UnaccompaniedMinorsInfo extends StatelessWidget {
  const UnaccompaniedMinorsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Unaccompanied Minors",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Container(
              width: 350,
              height: 600,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  buildSectionHeading("Important"),
                  Text("Travel regulations may vary by airline and destination. Please check with your airline and local authorities for the latest requirements.\n",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
  Widget buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}