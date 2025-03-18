import 'package:flutter/material.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jet_set_go/packing_tips/landing_page.dart';


  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await dotenv.load(fileName: ".env");

    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jet Set Go',
        home: LandingPage(),
      );
    }
  }