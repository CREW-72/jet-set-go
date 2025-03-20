import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jet_set_go/authentication/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      if (passwordController.text != confirmPasswordController.text) {
        _showError("Passwords do not match");
        setState(() => isLoading = false);
        return;
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'hasSetupTrip': false,
        'flightNumber': "",
      });

      if (mounted) {
        setState(() => isLoading = false);
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }

    } catch (e) {
      _showError(e.toString());
      if (mounted) {
        setState(() => isLoading = false);
      }
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

      DocumentReference userRef = _firestore.collection('users').doc(userCredential.user!.uid);
      DocumentSnapshot userDoc = await userRef.get();

      if (!userDoc.exists) {
        await userRef.set({
          'username': googleUser.displayName,
          'email': googleUser.email,
          'hasSetupTrip': false,
          'flightNumber': "",
        });
      } else {
        Map<String, dynamic> updatedFields = {};
        if (!userDoc.data().toString().contains('hasSetupTrip')) {
          updatedFields['hasSetupTrip'] = false;
        }
        if (!userDoc.data().toString().contains('flightNumber')) {
          updatedFields['flightNumber'] = "";
        }
        if (updatedFields.isNotEmpty) {
          await userRef.update(updatedFields);
        }
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your journey starts here! ✈️",
                        style: GoogleFonts.ubuntu(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      _buildTextField("Username", controller: usernameController),
                      _buildTextField("Email", controller: emailController, isEmail: true),
                      _buildTextField("Password", controller: passwordController, obscureText: true),
                      _buildTextField("Confirm Password", controller: confirmPasswordController, obscureText: true),
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Text("I agree with privacy policy", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 10),
                      isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text("Sign up", style: GoogleFonts.ubuntu(fontSize: 18, color: Colors.white)),
                      ),
                      SizedBox(height: 10),
                      Text("or", style: TextStyle(color: Colors.white, fontSize: 16)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/images/google.png', height: 24),
                            SizedBox(width: 10),
                            Text("Continue with Google", style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withAlpha(51),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "$hint is required";
          if (isEmail && !RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$').hasMatch(value)) {
            return "Enter a valid email";
          }
          return null;
        },
      ),
    );
  }
}
