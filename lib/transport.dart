import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _openRideApp(String packageName, String appStoreUrl) async {
    final Uri appUri = Uri.parse("intent://$packageName/#Intent;scheme=android-app;end;");
    if (await canLaunchUrl(appUri)) {
      await launchUrl(appUri);
    } else {
      await launchUrl(Uri.parse(appStoreUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/images/header.png", height: 160, fit: BoxFit.cover),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              'TRANSPORT',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3.0,
              ),
            ),
          ),
          Positioned(
            top: 113,
            left: 24,
            child: Text(
              'AND FAIR ASSISTANCE',
              style: TextStyle(fontSize: 20, color: Colors.white, letterSpacing: 2.0),
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            right: 120,
            child: Image.asset("assets/images/line.png", height: 8, fit: BoxFit.cover),
          ),
          Positioned(
            top: 100,
            right: 70,
            child: Image.asset("assets/images/planetakeoff.png", height: 50),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () {},
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        width: 100,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'TRAVEL OPTIONS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                'Transportation Tips',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0A4C80),
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        '- Popular Travel Options -',
                        style: TextStyle(fontSize: 25, color: Colors.white, letterSpacing: 2.0),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        padding: EdgeInsets.all(25),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        shrinkWrap: true,
                        children: [
                          _buildRideButton("assets/images/uber.png", "com.ubercab", "https://play.google.com/store/apps/details?id=com.ubercab"),
                          _buildRideButton("assets/images/pickme.png", "com.pickme.passenger", "https://play.google.com/store/apps/details?id=com.pickme.passenger"),
                          _buildRideButton("assets/images/kangaroo.png", "com.kangaroocabs", "https://play.google.com/store/apps/details?id=com.kangaroocabs"),
                          _buildRideButton("assets/images/yogo.png", "com.yogo.passenger", "https://play.google.com/store/apps/details?id=com.yogo.passenger"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        backgroundColor: Colors.blue[900],
        selectedItemColor: Color(0xFFACE6FC),
        unselectedItemColor: Color(0xFFACE6FC),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget _buildRideButton(String imagePath, String packageName, String appStoreUrl) {
    return GestureDetector(
      onTap: () => _openRideApp(packageName, appStoreUrl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}