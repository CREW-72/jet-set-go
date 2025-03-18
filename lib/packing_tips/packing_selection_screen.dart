import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jet_set_go/packing_tips/style.dart';
import 'tips_display_screen.dart';

class PackingSelectionScreen extends StatefulWidget {
  const PackingSelectionScreen({super.key});
  @override
  PackingSelectionScreenState createState() => PackingSelectionScreenState();
}

class PackingSelectionScreenState extends State<PackingSelectionScreen> {
  List<String> selectedCategories = [];

  final List<Map<String, dynamic>> categories = [
    {"title": "Toddlers (0-3 years)", "icon": Icons.baby_changing_station},
    {"title": "Young Children (4-10 years)", "icon": Icons.child_care},
    {"title": "Teenagers (11+ years)", "icon": Icons.boy},
  ];

  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'LUGGAGE',
      subtitle: 'PACKING TIPS',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Heading with subtle animation
            Text(
              "✈️ Select Age Groups for Packing Tips",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Get tailored packing suggestions based on age group.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 30),

            // Category selection with modern card design
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategories.contains(category["title"]);

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedCategories.remove(category["title"]);
                            } else {
                              selectedCategories.add(category["title"]);
                            }
                          });
                        },
                        child: SizedBox(
                          width: double.infinity, // Adjust the width as needed
                          height: 90, // Adjust the height as needed
                          child: Card(
                            elevation: isSelected ? 6 : 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: isSelected ? Colors.blue[900] : Colors.white,
                            child: ListTile(
                              leading: Icon(
                                category["icon"],
                                size: 30,
                                color: isSelected ? Colors.white : Colors.blue[900],
                              ),
                              title: Text(
                                category["title"],
                                style: GoogleFonts.mulish(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ),
                              trailing: Icon(
                                isSelected ? Icons.check_circle : Icons.circle_outlined,
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Add space between tiles
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // View Tips Button with stylish design
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedCategories.isNotEmpty
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TipsDisplayScreen(selectedCategories),
                          ),
                        );
                      }
                    : null, // Disables button if no selection
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedCategories.isNotEmpty ? Colors.blue : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: selectedCategories.isNotEmpty ? 5 : 0,
                ),
                child: Text(
                  "View Tips",
                  style: GoogleFonts.lobster(
                    textStyle: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}