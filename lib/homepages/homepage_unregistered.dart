import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ✅ Imported Firebase Firestore
import 'package:firebase_auth/firebase_auth.dart'; // ✅ Imported Firebase Auth
import 'package:jet_set_go/homepages/homepage_registered_user.dart';

class HomePageUnregistered extends StatefulWidget {
  const HomePageUnregistered({super.key});

  @override
  HomePageUnregisteredState createState() => HomePageUnregisteredState();
}

class HomePageUnregisteredState extends State<HomePageUnregistered> {
  final TextEditingController _flightNumberController = TextEditingController();
  String username = "User";

  @override
  void initState() {
    super.initState();
    _fetchUsername(); // Fetch username when the screen loads
  }

  void _showFlightNumberPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  "Enter Your Flight Number",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                SizedBox(height: 15),

                Text(
                  "Please refer to your air ticket and enter the flight number correctly to set up JetSetGo.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 15),

                // Flight Number Input Field
                TextField(
                  controller: _flightNumberController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "i.e. UL123 / EK456",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 20),

                // Buttons: "Setup" & "Cancel"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_flightNumberController.text.isNotEmpty) {
                          final user = FirebaseAuth.instance.currentUser; // ✅ Get the logged-in user
                          if (user != null) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .set({  // ✅ Store `hasSetupTrip` and `flightNumber` in Firestore
                              'hasSetupTrip': true,
                              'flightNumber': _flightNumberController.text.trim(),
                            }, SetOptions(merge: true)); // ✅ Ensure it doesn't overwrite other fields
                          }

                          Navigator.pop(context); // Close the popup first

                          // Navigate to Registered User Homepage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePageRegistered()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("Setup", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the popup without saving
                      },
                      child: Text("Cancel", style: TextStyle(color: Colors.red, fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _fetchUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc.data() != null) {
          setState(() {
            username = userDoc['username'] ?? "User";
          });
        }
      } catch (e) {
        print("Error fetching username: $e");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // TOP IMAGE WITH HAMBURGER MENU
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/planeimage.png",
                  height: 335,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  top: 50,
                  right: 15,
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.menu, color: Colors.black, size: 40),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    offset: Offset(0, 50),
                    onSelected: (value) {
                      switch (value) {
                        case 'Settings':
                          Navigator.pushNamed(context, '/settings');
                          break;
                        case 'Features':
                          Navigator.pushNamed(context, '/features');
                          break;
                        case 'Profile':
                          Navigator.pushNamed(context, '/profile');
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        _buildMenuItem(Icons.settings, 'Settings'),
                        _buildMenuItem(Icons.lightbulb, 'Features'),
                        _buildMenuItem(Icons.person, 'Profile'),
                      ];
                    },
                  ),
                ),
              ],
            ),
          ),

          // WELCOME MESSAGE AND BUTTONS
          Positioned(
            bottom: 85,
            left: 10,
            right: 10,
            child: Column(
              children: [
                // WELCOME MESSAGE
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [Colors.blue, Colors.cyanAccent, Colors.red, Colors.orange],
                          tileMode: TileMode.mirror,
                        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                      },
                      child: Text(
                        'WELCOME, ${username.isNotEmpty ? username.toUpperCase() : "USER"}!',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // SET UP TRIP BUTTON (SHOWS POPUP)
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: InkWell(
                      onTap: _showFlightNumberPopup, // Show the popup when clicked
                      child: Ink(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/button1.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/setup.png",
                                height: 200,
                                width: 300,
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Set-up your Trip',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3),

                // FAQ & APP GUIDE BUTTONS
                Row(
                  children: [
                    _buildCardButton("assets/images/FAQ.png", "FAQ"),
                    SizedBox(width: 5),
                    _buildCardButton("assets/images/guide.png", "App Guide"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function for menu items
  PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // Helper function for FAQ & App Guide buttons
  Expanded _buildCardButton(String imagePath, String title) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: InkWell(
          onTap: () {},
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/button1.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image.asset(
                    imagePath,
                    height: 100,
                    width: 200,
                  ),
                  SizedBox(height: 30),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
