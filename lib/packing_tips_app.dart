// lib/packing_tips_app.dart
import 'package:flutter/material.dart';
import 'packing_selection_screen.dart';

class PackingTipsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PackingSelectionScreen(),
    );
  }
}