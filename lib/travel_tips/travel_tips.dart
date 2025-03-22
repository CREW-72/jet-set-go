import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/homepages/homepage_registered_user.dart';

class TravelTipsApp extends StatelessWidget {
  const TravelTipsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TravelTipsScreen();
  }
}

class TravelTipsScreen extends StatelessWidget {
  TravelTipsScreen({super.key});

  final List<Map<String, dynamic>> travelTipsCategories = [
    {'title': 'Entering the Airport', 'tips': ['Arrive early', 'Keep ID ready', 'Follow security protocols']},
    {'title': 'Check-in', 'tips': ['Use online check-in', 'Keep boarding pass handy', 'Check baggage allowance']},
    {'title': 'Immigration', 'tips': ['Have visa & passport ready', 'Fill out required forms', 'Follow officer instructions']},
    {'title': 'Waiting for the Plane', 'tips': ['Monitor flight status', 'Charge devices', 'Stay near gate']},
    {'title': 'Lounge Experience', 'tips': ['Use lounge access', 'Enjoy free Wi-Fi', 'Refresh before flight']},
    {'title': 'In-Flight Etiquette', 'tips': ['Keep seat upright', 'Respect fellow passengers', 'Follow cabin crew instructions']},
    {'title': 'Landing at Destination', 'tips': ['Follow deboarding rules', 'Have customs forms ready', 'Claim baggage promptly']},
  ];

  PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/images/headerBackground.png", height: 160, fit: BoxFit.cover),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.07,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Text(
              'TRAVEL',
              style: GoogleFonts.ubuntu(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3.0,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.width * 0.06,
            child: Text(
              'TIPS',
              style: GoogleFonts.ubuntu(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16, left: 25),
            width: 275,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.11,
            right: MediaQuery.of(context).size.width * 0.18,
            child: Image.asset("assets/images/takeoff.png", height: 40),
          ),

          // 🍔 Hamburger Menu (Top Right)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.06,
            right: MediaQuery.of(context).size.width * 0.04,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.white, size: 40),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: const Offset(0, 50),
              onSelected: (value) {
                switch (value) {
                  case 'Home':
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePageRegistered()),
                    );
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

          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight + 12, left: 12, right: 12),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: travelTipsCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TipsDetailScreen(
                          title: travelTipsCategories[index]['title'],
                          tips: travelTipsCategories[index]['tips'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    color: Colors.white.withAlpha(204),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          travelTipsCategories[index]['title'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ubuntu(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TipsDetailScreen extends StatelessWidget {
  const TipsDetailScreen({super.key, required this.title, required this.tips});
  final String title;
  final List<String> tips;

  PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔵 Header background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/headerBackground.png",
              height: 160,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: screenHeight * 0.07,
            right: screenWidth * 0.04,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.white, size: 40),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: const Offset(0, 50),
              onSelected: (value) {
                switch (value) {
                  case 'Home':
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePageRegistered()),
                    );
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

          Positioned(
            top: screenHeight * 0.11,
            right: screenWidth * 0.18,
            child: Image.asset("assets/images/takeoff.png", height: 40),
          ),

          Positioned(
            top: screenHeight * 0.07,
            left: screenWidth * 0.05,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title.split(' ').first.toUpperCase(),
                style: GoogleFonts.ubuntu(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 3.0,
                ),
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.12,
            left: screenWidth * 0.06,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title.split(' ').length > 1
                    ? title.split(' ').sublist(1).join(' ').toUpperCase()
                    : "",
                style: GoogleFonts.ubuntu(
                  fontSize: screenWidth * 0.045,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),

          // Divider Line
          Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.16,
                left: 25),
            width: 275,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.21,
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: tips.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white.withAlpha(212),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green.shade700, size: 28),
                    title: Text(
                      tips[index],
                      style: GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
