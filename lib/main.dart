import 'package:flutter/material.dart';
import 'package:jet_set_go/flight_tracking_page.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jet Set Go',
      initialRoute: '/',
      routes: {
        '/': (context) => FlightTrackingPage(),
      },
    );
  }
}