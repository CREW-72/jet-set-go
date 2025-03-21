import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jet_set_go/airport_navigation/navigation_landing.dart';
import 'package:jet_set_go/landing_page/landing_page.dart'; // Set Loading Page as Home

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase globally
  await dotenv.load(fileName: ".env"); // Load environment variables

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jet Set Go',
      home: NavigationLanding(), // Set Landing Page as the entry point
    );
  }
}
