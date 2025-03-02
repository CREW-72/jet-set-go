import 'package:flutter/material.dart';

class UI extends StatelessWidget {
  final Widget body;
  final BottomNavigationBar? bottomNavigationBar;

  const UI({
    required this.body,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BACKGROUND PICTURE WITH BODY
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: body, // Embedding the body here
          ),
          // Header Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/app_bar_bg.jpg",
              height: 126,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top:0,
            left: 0,right: 0,
            child: Image.asset(
              "assets/plane_bg.jpg",
              height: 126,// Adjust the size as needed
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top:80,
            left: 130,right: 0,
            child: Image.asset(
              "assets/plane_icon.jpg",
              height: 50,// Adjust the size as needed
            ),
          ),
          Positioned(
            top:100,
            left: 20,right: 170,
            child: Image.asset(
              "assets/line.jpg",
              height: 50,// Adjust the size as needed
            ),
          ),
          Positioned(
            top: 25,
            left: 20,
            child: Text('SPECIAL', style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 3.0, // Increase the width of the letters
            ),),
          ),
          Positioned(
            top: 85,
            left: 20,
            child: Text('ASSISTANCE',style: TextStyle(fontSize: 20,color: Colors.white,letterSpacing: 2.0,),),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar ??
          BottomNavigationBar(
            backgroundColor: Colors.blue[900],
            selectedItemColor: const Color(0xFFACE6FC),
            unselectedItemColor: const Color(0xFFACE6FC),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
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