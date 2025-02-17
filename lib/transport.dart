import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Set background color to white
              ),
          ),

          // Header Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/header.png",
              height: 160,
              fit: BoxFit.cover,
            ),
          ),

          //HEADER
          Positioned(
            top: 50, // Moves text 50 pixels from the top
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
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ),

          // Line Image
          Positioned(
            top: 150,
            left: 20,
            right: 120,
            child: Image.asset(
              "assets/images/line.png",
              height: 8,
              fit: BoxFit.cover,
            ),
          ),

          // Line Image
          Positioned(
            top: 100,
            right: 70,
            child: Image.asset(
              "assets/images/planetakeoff.png",
              height: 50,
            ),
          ),

          Positioned(
            top: 50, // Adjust as needed
            right: 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white, // Border color
                  width: 4, // Thick border
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28, // Arrow size
                ),
                padding: EdgeInsets.zero, // Remove extra padding
                onPressed: () {
                },
              ),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.1, // Shows small part at bottom
            minChildSize: 0.1, // Minimum visible size
            maxChildSize: 0.6, // Maximum size when dragged
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Drag Handle
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: 100,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.all(20),
                        children: [
                          Center(
                            child: Text(
                              'TRAVEL OPTIONS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Button 1"),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Button 2"),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Button 3"),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Button 4"),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Button 5"),
                          ),

                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Button 5"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ), 

      // Bottom Navigation Bar
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
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.home),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.settings),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.lightbulb),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.person),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
