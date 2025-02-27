import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jet_set_go/screens/welcome_screen.dart';
import 'package:jet_set_go/screens/signup_page.dart';
import 'package:jet_set_go/screens/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jet Set Go',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}