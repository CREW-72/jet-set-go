import 'package:flutter/material.dart';
import 'package:jet_set_go/landingPage.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Landingpage(),
    },
  ));
}