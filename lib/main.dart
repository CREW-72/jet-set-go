import 'package:flutter/material.dart';
import 'package:jet_set_go/loadingpage.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LoadingPage(),
    },
  ));
}