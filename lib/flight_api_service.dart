import 'dart:convert';
import 'package:http/http.dart' as http;

class FlightApiService {
  static const String baseUrl = "https://us-central1-jetsetgo-ee55b.cloudfunctions.net"; // Firebase function URL

  // Fetch flight details from backend
  Future<Map<String, dynamic>?> getFlightDetails(String flightNumber) async {
    final Uri url = Uri.parse("$baseUrl/getFlightDetails?flightNumber=$flightNumber");

    try {
      print("Making API request: $url ");
      
      final response = await http.get(url);

      print("🔹 API Response Status: ${response.statusCode}"); // Debug log
      print("📩 API Response Body: ${response.body}"); // Debug log

      if (response.statusCode == 200) {
        return json.decode(response.body); // ✅ Return JSON response
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("API Request Failed: $e");
      return null;
    }
  }
}
