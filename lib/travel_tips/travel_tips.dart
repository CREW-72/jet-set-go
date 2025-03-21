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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.withAlpha(230),
        elevation: 0,
        title: Text('Air Travel Tips', style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePageRegistered()),
            );
          },
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.withAlpha(230),
        elevation: 0,
        title: Text(title, style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight + 12),
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
