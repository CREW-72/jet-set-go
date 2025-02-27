import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
  ));
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Ensures full width
        height: double.infinity, // Ensures full height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"), // Background pattern
            fit: BoxFit.cover,
          ),
        ),
        child: Center( // Centers all content
          child: Column(
            mainAxisSize: MainAxisSize.min, // Avoids unnecessary space
            children: [
              Image.asset("assets/images/welcome.png", width: 400), // Main image
              SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: "JET.", style: TextStyle(color: Colors.blue)),
                    TextSpan(text: "SET.", style: TextStyle(color: Colors.red)),
                    TextSpan(text: "GO", style: TextStyle(color: Colors.yellow)),
                  ],
                ),
              ),
              SizedBox(height: 40),
              CustomButton(text: "Login", onTap: () {}),
              SizedBox(height: 15),
              CustomButton(text: "Sign up", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  CustomButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: 200, // Button takes full width within padding
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
            minimumSize: Size(100, 50), // Ensures a minimum button width
          ),
          onPressed: onTap,
          child: Text(text, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
