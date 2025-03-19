import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
                  top: 50, // Adjusted position for better alignment
                  right: 15,
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.menu, color: Colors.black, size: 40), // Hamburger Icon
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    offset: Offset(0, 50), // Moves the menu DOWN
                    onSelected: (value) {
                      switch (value) {
                        case 'Home':
                          Navigator.pushNamed(context, '/home');
                          break;
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
                        _buildMenuItem(Icons.home, 'Home'),
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
                        'WELCOME, USER!',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // SET UP TRIP BUTTON
                SizedBox(
                  width: double.infinity,
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
