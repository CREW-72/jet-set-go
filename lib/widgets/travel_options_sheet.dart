import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TravelOptionsSheet extends StatelessWidget {
  const TravelOptionsSheet({super.key});

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
    return DraggableScrollableSheet(
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
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/whitebg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          'Transportation Tips  ->',
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
                  physics: NeverScrollableScrollPhysics(), // Prevent double scrolling
                  children: [
                    _buildRideButton("assets/images/uber.png", "com.ubercab", "https://play.google.com/store/apps/details?id=com.ubercab"),
                    _buildRideButton("assets/images/pickme.png", "com.pickme.passenger", "https://play.google.com/store/apps/details?id=com.pickme.passenger"),
                    _buildRideButton("assets/images/kangaroo.png", "com.kangaroocabs", "https://play.google.com/store/apps/details?id=com.kangaroocabs"),
                    _buildRideButton("assets/images/yogo.png", "com.yogo.passenger", "https://play.google.com/store/apps/details?id=com.yogo.passenger"),
                    _buildRideButton("assets/images/yangoo.png", "com.yangoo.app", "https://play.google.com/store/apps/details?id=com.yangoo.app"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
