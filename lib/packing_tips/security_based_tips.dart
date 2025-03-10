import 'package:flutter/material.dart';
import 'package:jet_set_go/packing_tips/weather_based_tips.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // Import the UI class

class SecurityBasedTips extends StatelessWidget {
  final Map<String, List<Map<String, String>>> tips = {
    "Security Regulations": [
      {"title": "Follow TSA Rules", "icon": "🛃", "desc": "Keep liquids in 100ml bottles and place them in a clear, zip-lock bag."},
      {"title": "Avoid Prohibited Items", "icon": "🚫", "desc": "Check airline guidelines on restricted objects (e.g., sharp objects, aerosols)."},
      {"title": "Keep Essentials Handy", "icon": "📄", "desc": "Store travel documents, ID, and medications in an easily accessible pouch."},
      {"title": "Luggage Locks & Tags", "icon": "🔒", "desc": "Use TSA-approved locks and add visible luggage tags to prevent mix-ups."},
      {"title": "Secure Valuables", "icon": "💰", "desc": "Carry cash, jewelry, and electronics in your hand luggage."},
      {"title": "Battery & Power Banks", "icon": "🔋", "desc": "Ensure power banks are in your carry-on, as airlines may restrict them in checked baggage."},
      {"title": "Weight Distribution", "icon": "⚖️", "desc": "Distribute heavy items evenly to avoid overweight charges."}
    ],
    "Baggage Policy": [
      {"title": "Oversized Baggage Policy", "icon": "📏", "desc": "Bags exceeding 158cm (Height+Length+Width) incur a USD 50 charge per bag. Acceptance depends on aircraft type. Sporting equipment is handled separately."},
      {"title": "Cabin Baggage Allowance", "icon": "🎒", "desc": "Business Class: 7kg, 2 pieces | Economy Class: 7kg, 1 piece."},
      {"title": "Additional Free Carry-On Items", "icon": "👜", "desc": "Includes one laptop, handbag/purse, overcoat, umbrella, small camera/binoculars. Duty-free items must fit in the overhead bin."},
      {"title": "Passengers Traveling with Infants", "icon": "👶", "desc": "One cabin bag (56cm x 36cm x 23cm, max 5kg) with infant essentials. Strollers allowed in the cabin if space permits, otherwise checked in."}
    ],
    "Hand Luggage Restrictions": [
      {"title": "Hand Baggage Restrictions", "icon": "🚫", "desc": "Hand baggage may be denied boarding if it's too heavy, oversized, or improperly packed."},
      {"title": "Storage Limits", "icon": "📦", "desc": "Baggage must fit under the seat or in the overhead compartment."},
      {"title": "Prohibited Items", "icon": "⚠️", "desc": "Bags containing restricted or prohibited items may not be allowed on board."}
    ],
    "Important Security Guidelines": [
      {"title": "Operator’s Consent Required", "icon": "🛃", "desc": "Certain items need operator approval due to their weight, size, or nature."},
      {"title": "Liquid & Gel Restrictions", "icon": "💧", "desc": "Many countries restrict liquids, aerosols, and gels in hand baggage."},
      {"title": "Security Screening Compliance", "icon": "🔍", "desc": "Items denied at security must be checked in per airline policy."}
    ],
    "Prohibited Items": [
      {"title": "Dangerous Items", "icon": "⚠️", "desc": "Sharp objects, weapons, or irregular metal items over 5kg are restricted."},
      {"title": "Live Animals", "icon": "🐶", "desc": "Only pets like dogs, cats, and household birds are allowed per airline regulations."},
      {"title": "Firearms & Ammunition", "icon": "🔫", "desc": "Permitted only for hunting or sporting purposes with proper authorization."},
      {"title": "Lithium-Powered Small Vehicles", "icon": "🛵", "desc": "Not allowed as they are classified as dangerous goods."},
      {"title": "Valuables", "icon": "💎", "desc": "Money, jewelry, passports, and business documents must be carried in hand baggage."}
    ],
    "Baggage Interlining": [
      {"title": "Baggage Transfer Restrictions", "icon": "🔄", "desc": "Baggage may not transfer if traveling domestically, using separate tickets, or connecting to budget carriers."},
      {"title": "Indian Destination Rule", "icon": "🇮🇳", "desc": "Baggage interlining is not available for Indian destinations except New Delhi."},
      {"title": "Check Your Allowance", "icon": "📲", "desc": "Use the airline’s 'Manage My Booking' feature to check baggage allowance for your ticket."}
    ],
  };

  @override
  Widget build(BuildContext context) {
    return UI(
      title: 'SECURITY TIPS',
      subtitle: 'FOR SAFE TRAVEL',
      body: DefaultTabController(
        length: tips.keys.length,
        child: Column(
          children: [
            SizedBox(height: 130),
            TabBar(
              isScrollable: true,
              labelColor: Colors.white, // Selected tab text color
              unselectedLabelColor: Colors.grey, // Unselected tab text color
              tabs: tips.keys.map((category) => Tab(text: category)).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: tips.keys.map((category) {
                  return ListView(
                    padding: EdgeInsets.all(10),
                    children: tips[category]!.map((tip) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Text(tip["icon"]!, style: TextStyle(fontSize: 24)),
                          title: Text(tip["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(tip["desc"]!),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: SizedBox(
                width: 300,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherBasedTips(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward, color: Colors.blue),
                  label: Text("Next"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}