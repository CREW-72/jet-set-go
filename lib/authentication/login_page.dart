import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jet_set_go/authentication/signup_page.dart';
import 'package:jet_set_go/homepages/homepage_unregistered.dart';
import 'package:jet_set_go/homepages/homepage_registered_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _rememberMe = false;
  bool isLoading = false;

  Future<void> _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showError("Please enter both email and password.");
      return;
    }

    setState(() => isLoading = true);

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final User? user = userCredential.user;

      if (user != null) {
        DocumentReference userRef = _firestore.collection('users').doc(user.uid);
        DocumentSnapshot userDoc = await userRef.get();

        bool hasSetupTrip = false;
        if (userDoc.exists) {
          hasSetupTrip = userDoc['hasSetupTrip'] ?? false;
        } else {
          // ✅ If document does not exist, create with default values
          await userRef.set({
            'hasSetupTrip': false,
            'flightNumber': "", // Ensure field exists for future use
          }, SetOptions(merge: true));
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => hasSetupTrip ? HomePageRegistered() : HomePageUnregistered(),
            ),
          );
        }
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => isLoading = true);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        DocumentReference userRef = _firestore.collection('users').doc(user.uid);
        DocumentSnapshot userDoc = await userRef.get();

        bool hasSetupTrip = false;
        if (userDoc.exists) {
          hasSetupTrip = userDoc['hasSetupTrip'] ?? false;
        } else {
          // create with default values
          await userRef.set({
            'hasSetupTrip': false,
            'flightNumber': "", // Ensure field exists for future use
          }, SetOptions(merge: true));
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => hasSetupTrip ? HomePageRegistered() : HomePageUnregistered(),
            ),
          );
        }
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background.jpg',
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
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
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
              Positioned(
                top: size.height * 0.36,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField("Email", controller: emailController, isEmail: true),
                    SizedBox(height: 16),
                    _buildTextField("Password", controller: passwordController, obscureText: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : ElevatedButton(
                        onPressed: _login,
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
                    SizedBox(height: 10),

                    Text("or",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20,)),

                    SizedBox(height: 10),

                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 280, // Ensure fixed width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            minimumSize: Size(200, 50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person, color: Colors.white, size: 24),
                              SizedBox(width: 10),
                              Text(
                                "Create an account",
                                style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 110,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF87A8EE).withAlpha(153),
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
        ),
      ),
    );
  }
  }

  Widget _buildTextField(String hint, {bool obscureText = false, bool isEmail = false, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        style: TextStyle(color: Colors.white, fontFamily: 'Poppins'), // ✅ FIXED TEXT VISIBILITY
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
          filled: true,
          fillColor: Colors.white.withAlpha(51),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }
