import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisabilityForm extends StatelessWidget {
  const DisabilityForm({super.key});

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
                  "Disability Assistance Request Form",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Icon(Icons.file_open_outlined, color: Colors.white, size: 150),
              SizedBox(height: 12),
              Text(
                "This form is provided by Sri Lankan Airlines to request assistance.\nPlease note that, this is not available for flights departing in the next 72 hours.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _launchFormURL();
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
  }void _launchFormURL() async{
    const formUrl = 'https://www.srilankan.com/en_uk/flying-with-us/disability-assistance-request';
    final uriForm =Uri.parse(formUrl);
    if(await canLaunchUrl(uriForm)) {
      await launchUrl(uriForm);
    }else{
      throw 'Could not launch url' ;
    }
  }
}
