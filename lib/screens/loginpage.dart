import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushReplacementNamed(context, '/');  // Navigate to Home Screen after login
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

      await _auth.signInWithCredential(credential);

      Navigator.pushReplacementNamed(context, '/');
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
      resizeToAvoidBottomInset: true,  // ✅ Prevents UI overlap with keyboard
      body: SingleChildScrollView(  // ✅ Allows scrolling when keyboard appears
        child: Container(
          height: size.height,  // ✅ Ensures full-screen height
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
                            // TODO: Implement Forgot Password feature
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 2.0,
                          width: 330.0,
                          color: Colors.white,
                        ),
                        Image.asset(
                          'assets/images/plane.png',
                          width: 50.0,
                          height: 50.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
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
                    Text("or", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Poppins')),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _signInWithGoogle,
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
        style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }
}
