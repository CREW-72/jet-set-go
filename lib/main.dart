import 'package:flutter/material.dart';
import 'package:jet_set_go/special_assistance_landingpage.dart';
import 'package:jet_set_go/specialassistance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const special_assistance_landing_page(),
    );
  }
}