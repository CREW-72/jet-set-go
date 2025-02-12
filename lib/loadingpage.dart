import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/sky_background.png',
              fit: BoxFit.cover,
            ),
          ),
          // GIF in the center
          Center(
            child: Image(
              image: NetworkImageWithRetry('assets/loading_gif.gif'),
              height: 150,
            ),
          ),
          // Logo at the bottom
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/logo.png',
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
