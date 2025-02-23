import 'package:flutter/material.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _rememberMe = false; // Checkbox state

  @override
  Widget build(BuildContext context) {
    // Get screen size to help position elements
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 21,
            left: 50.0,
            right: 50.0,
            child: Opacity(
              opacity: 0.9,
              child: SizedBox(
                width: 350.0,
                height: 350.0,
                child: Image.asset(
                  'assets/images/airhostess.png',
                  fit: BoxFit.contain, // Ensure proper scaling
                ),
              ),
            ),
          ),

          // Positioned Title Text Separately
          Positioned(
            top: size.height * 0.25,
            left: 20,
            right: 20,
            child: Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 41,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Positioned Input Fields and Login Button
          Positioned(
            top: size.height * 0.36,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField("Email"),
                SizedBox(height: 16), // Space between text fields
                _buildTextField("Password", obscureText: true),

                // Checkbox for "Remember Me"
                // Checkbox for "Remember Me" and "Forgot Password" Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Push items to opposite sides
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                          activeColor: Colors.deepPurpleAccent,
                        ),
                        Text(
                          "Remember Me",
                          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password functionality
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.underline, // Add underline for emphasis
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Login Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Positioned Bottom Buttons
          Positioned(
            left: 20,
            right: 20,
            bottom: 110,  // Adjust this as necessary
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row to place line and plane image next to each other
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the row content
                  children: [
                    // Line
                    Container(
                      height: 2.0,  // Line thickness
                      width: 330.0, // Line length, adjust as needed
                      color: Colors.white,  // Line color
                    ),

                    // Plane Image
                    Image.asset(
                      'assets/images/plane.png',  // Your plane image path
                      width: 50.0,  // Adjust the size as necessary
                      height: 50.0, // Adjust the size as necessary
                    ),
                  ],
                ),
                SizedBox(height: 16), // Space between the row and the buttons

                // Create New Account Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF87A8EE).withOpacity(0.6),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/newAccount.png', height: 27),
                      SizedBox(width: 10),
                      Text("Create New Account",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Poppins')),
                    ],
                  ),
                ),
                SizedBox(height: 15),

                // "or" Text
                Text("or", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Poppins')),
                SizedBox(height: 10),

                // Continue with Google Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF87A8EE).withOpacity(0.6),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/google.png', height: 27),
                      SizedBox(width: 10),
                      Text("Continue with Google",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Poppins')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create text fields
  Widget _buildTextField(String hint, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        style: TextStyle(color: Colors.white, fontFamily: 'Poppins'), // Use Poppins font
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }
}
