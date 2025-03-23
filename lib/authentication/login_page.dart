import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jet_set_go/authentication/signup_page.dart';
import 'package:jet_set_go/homepages/homepage_unregistered.dart';
import 'package:jet_set_go/homepages/homepage_registered_user.dart';
import 'package:google_fonts/google_fonts.dart';

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
          await userRef.set({
            'hasSetupTrip': false,
            'flightNumber': "",
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
            'flightNumber': "",
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
        physics: BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                top: MediaQuery.of(context).size.height * 0.07,
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Opacity(
                  opacity: 0.9,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.30,
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
                  style: GoogleFonts.ubuntu(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    fontWeight: FontWeight.w700,
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
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: MediaQuery.of(context).size.width * 0.15,
                          ),
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
                    SizedBox(height: 2),

                    Text("or",textAlign: TextAlign.center, style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20,)),

                    SizedBox(height: 4),

                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.01,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person, color: Colors.white, size: MediaQuery.of(context).size.width * 0.06),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                              Text(
                                "Create an account",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
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
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.07,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: _signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF87A8EE).withAlpha(153),
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.01,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            Text(
                              "Continue with Google",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
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
  Widget _buildTextField(String hint, {bool obscureText = false, bool isEmail = false, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        style: GoogleFonts.ubuntu(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.ubuntu(
            color: Colors.white70,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
          filled: true,
          fillColor: Colors.white.withAlpha(51),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
        ),

      ),
    );
  }

}

