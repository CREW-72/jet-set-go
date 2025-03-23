import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:jet_set_go/flight_tracking/flight_api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ✅ Imported Firebase Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import API Service

class FlightTrackingPage extends StatefulWidget {
  const FlightTrackingPage({super.key});

  @override
  FlightTrackingPageState createState() => FlightTrackingPageState();
}

class FlightTrackingPageState extends State<FlightTrackingPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  String? _firestoreFlightNumber; // Store flight number from Firestore
  Flight? _flight;
  Timer? _refreshTimer;
  final FlightApiService _apiService = FlightApiService(); // Initialize API service

  @override
  void initState() {
    super.initState();
    _fetchFlightNumberFromFirestore();

    // Set up auto-refresh every 5 minutes
    _refreshTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      _refreshFlightData();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel(); // Stop auto-refresh to prevent memory leaks
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchFlightNumberFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc.data() != null) {
          setState(() {
            _firestoreFlightNumber = userDoc['flightNumber'] ?? "";
            if (_firestoreFlightNumber!.isNotEmpty) {
              _searchController.text = _firestoreFlightNumber!; // Prefill search bar
              _searchFlight(_firestoreFlightNumber!); // Fetch flight details immediately
            }
          });
        }
      } catch (e) {
        throw Exception("Error fetching flight number: $e");
      }
    }
  }

  Future<void> _updateFlightNumber() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && _searchController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'flightNumber': _searchController.text.trim(),
        }, SetOptions(merge: true));

        setState(() {
          _firestoreFlightNumber = _searchController.text.trim();
          _hasError = false;
          _errorMessage = '';
        });

        _searchFlight(_firestoreFlightNumber);
      } catch (e) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Error updating flight number. Please try again.';
        });
      }
    }
  }

  Future<void> _searchFlight([String? flightNumber]) async {
    String finalFlightNumber = flightNumber ?? _firestoreFlightNumber ?? '';

    if (finalFlightNumber.isEmpty) {
      setState(() {
        _hasError = true;
        _errorMessage = 'No flight number found. Please enter one.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      final flightData = await _apiService.getFlightDetails(finalFlightNumber);

      if (flightData != null) {
        setState(() {
          _flight = Flight.fromJson(flightData);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'Flight not found or has ended. Please enter a new flight number.';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Failed to fetch flight data. Please try again.';
      });
    }
  }

  Future<void> _refreshFlightData() async {
    if (_flight == null) return;

    try {
      final updatedFlight = await _apiService.getFlightDetails(_flight!.flightNumber);

      if (updatedFlight != null) {
        setState(() {
          _flight = Flight.fromJson(updatedFlight);
        });
      }
    } catch (e) {
      // Handle refresh error silently
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color(0xFF0A1F44);
    final cardColor = Color(0xFF1C3C78);
    final textColor = Colors.white;
    final subtitleColor = Color(0xFFB0C4DE);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Flight Details'),
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshFlightData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show Search Bar **ONLY IF NO SAVED FLIGHT NUMBER**
                if (_firestoreFlightNumber == null || _firestoreFlightNumber!.isEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1D3557),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: subtitleColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Enter flight number (e.g., UA123)',
                                hintStyle: TextStyle(color: subtitleColor),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(color: textColor),
                              onSubmitted: _searchFlight,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            color: Color(0xFF00A6FF),
                            onPressed: () => _searchFlight(_searchController.text),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                // Error Message
                if (_hasError)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.withAlpha(26),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _errorMessage,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // New Flight Number Input
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF1D3557),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Enter new flight number (e.g., EK123)',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Update Button
                      ElevatedButton(
                        onPressed: () => _updateFlightNumber(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("Update Flight", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ],
                  ),

                // Loading Shimmer
                if (_isLoading) _buildLoadingShimmer(cardColor),

                // Flight Information
                if (!_isLoading && _flight != null) ...[
                  _buildFlightHeader(_flight!, textColor, subtitleColor),
                  const SizedBox(height: 12),
                  _buildFlightRoute(_flight!, textColor, subtitleColor, cardColor),
                  const SizedBox(height: 12),
                  _buildFlightDetails(_flight!, textColor, subtitleColor, cardColor),
                  const SizedBox(height: 12),
                  _buildFlightTimeline(_flight!, textColor, subtitleColor, cardColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer(Color? cardColor) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }



Widget _buildFlightHeader(Flight flight, Color textColor, Color? subtitleColor) {
    Color statusColor;
    switch (flight.status) {
      case FlightStatus.onTime:
        statusColor = Colors.green;
        break;
      case FlightStatus.delayed:
        statusColor = flight.delayMinutes! > 60 ? Colors.red : Colors.orange;
        break;
      case FlightStatus.boarding:
        statusColor = Colors.green;
        break;
      case FlightStatus.departed:
      case FlightStatus.inAir:
        statusColor = Colors.blue;
        break;
      case FlightStatus.arrived:
        statusColor = Colors.green;
        break;
      case FlightStatus.cancelled:
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1E3A5F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withAlpha(77), width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 24,
            child: Text(
              flight.airline.code,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${flight.airline.name} ${flight.flightNumber}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${flight.origin.city} to ${flight.destination.city}',
                  style: TextStyle(
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(51),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getStatusIcon(flight.status),
                  size: 16,
                  color: statusColor,
                ),
                const SizedBox(width: 4),
                Text(
                  _getStatusText(flight.status),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightRoute(Flight flight, Color textColor, Color? subtitleColor, Color? cardColor) {
    final timeFormat = DateFormat('HH:mm');
    final dateFormat = DateFormat('EEE, MMM d');

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flight.origin.code,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      flight.origin.city,
                      style: TextStyle(
                        fontSize: 16,
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      //THIS RETURNS TIME RIGHT NOW IF ACTUAL AND SCHEDULED IS NOT LISTED.
                      timeFormat.format(flight.departure.actual ?? flight.departure.scheduled ?? DateTime.now()),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      //THIS RETURNS TIME RIGHT NOW IF DEPARTURE TIME IS NOT PROVIDED
                      dateFormat.format(flight.departure.scheduled??DateTime.now()),
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF00A6FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Gate ${flight.origin.gate}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.flight_takeoff,
                    size: 24,
                    color: Color(0xFF00A6FF),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 1,
                    color: Colors.grey.withAlpha(77),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.flight_land,
                    size: 24,
                    color: Color(0xFF00A6FF),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      flight.destination.code,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      flight.destination.city,
                      style: TextStyle(
                        fontSize: 16,
                        color: subtitleColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      //SHOWS TIME RIGHT NOW IF ARRIVAL ESTIMATED, SCHEDULED IS N/A
                      timeFormat.format(flight.arrival.estimated ?? flight.arrival.scheduled ?? DateTime.now()),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      //SHOWS TIME RIGHT NOW IF ARRIVAL SCHEDULED IS N/A
                      dateFormat.format(flight.arrival.scheduled??DateTime.now()),
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF00A6FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Gate ${flight.destination.gate}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (flight.delayMinutes != null && flight.delayMinutes! > 0) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withAlpha(26),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withAlpha(77)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Flight is delayed by ${flight.delayMinutes} minutes',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFlightTimeline(Flight flight, Color textColor, Color? subtitleColor, Color? cardColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: 400,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flight Timeline',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 12,),
          Text(
            'Feature will be available soon!',
            style:TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightDetails(Flight flight, Color textColor, Color? subtitleColor, Color? cardColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flight Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Airline', flight.airline.name, textColor, subtitleColor),
          _buildDetailRow('Flight', flight.flightNumber, textColor, subtitleColor),
          if (flight.aircraft != null) ...[
            _buildDetailRow('Aircraft', flight.aircraft!.model, textColor, subtitleColor),
            _buildDetailRow('Registration', flight.aircraft!.registration, textColor, subtitleColor),
          ],
          _buildDetailRow('Origin Terminal', flight.origin.terminal ?? 'N/A', textColor, subtitleColor),
          _buildDetailRow('Destination Terminal', flight.destination.terminal ?? 'N/A', textColor, subtitleColor),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Color textColor, Color? subtitleColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: subtitleColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(FlightStatus status) {
    switch (status) {
      case FlightStatus.onTime:
        return Icons.check_circle;
      case FlightStatus.delayed:
        return Icons.access_time;
      case FlightStatus.boarding:
        return Icons.airline_seat_recline_normal;
      case FlightStatus.departed:
        return Icons.flight_takeoff;
      case FlightStatus.inAir:
        return Icons.flight;
      case FlightStatus.arrived:
        return Icons.flight_land;
      case FlightStatus.cancelled:
        return Icons.cancel;
      default:
        return Icons.check_circle;
    }
  }

  String _getStatusText(FlightStatus status) {
    switch (status) {
      case FlightStatus.onTime:
        return 'On Time';
      case FlightStatus.delayed:
        return 'Delayed';
      case FlightStatus.boarding:
        return 'Boarding';
      case FlightStatus.departed:
        return 'Departed';
      case FlightStatus.inAir:
        return 'In Air';
      case FlightStatus.arrived:
        return 'Arrived';
      case FlightStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Scheduled';
    }
  }

}


// Models
enum FlightStatus {
  onTime,
  delayed,
  boarding,
  departed,
  inAir,
  arrived,
  cancelled,
  unknown,
}

enum EventType {
  checkIn,
  security,
  boarding,
  departure,
  arrival,
  unknown,
}

class Airline {
  final String code;
  final String name;

  Airline({required this.code, required this.name});

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      code: json['iata'] ?? 'Unknown Code',
      name: json['airlineName'] ?? 'Unknown Airline', // Directly using API response
    );
  }
}


class Airport {
  final String code;
  final String name;
  final String city;
  final String? terminal;
  final String? gate;

  Airport({
    required this.code,
    required this.name,
    required this.city,
    this.terminal,
    this.gate,
  });

  factory Airport.fromJson(Map<String,dynamic> json){
    return Airport(
      code: json['code']??'Unknown Code',
      name: json['name']??'Unknown Airport',
      city: json['city']??'Unknown City',
      terminal: json['terminal'] == 'N/A' ? null : json['terminal'],
      gate: json['gate'] == 'N/A' ? "TBD" : json['gate'],
    );
  }
}

class FlightTime {
  final DateTime? scheduled;
  final DateTime? estimated;
  final DateTime? actual;

  FlightTime({
    this.scheduled,
    this.estimated,
    this.actual,
  });

  factory FlightTime.fromJson(Map<String, dynamic> json) {
    return FlightTime(
      scheduled: (json['scheduled'] != null && json['scheduled'] != 'N/A')
          ? DateTime.tryParse(json['scheduled'])
          : null,
      estimated: (json['estimated'] != null && json['estimated'] != 'N/A')
          ? DateTime.tryParse(json['estimated'])
          : null,
      actual: (json['actual'] != null && json['actual'] != 'N/A')
          ? DateTime.tryParse(json['actual'])
          : null,
    );
  }
}

class Aircraft {
  final String registration;
  final String model;

  Aircraft({required this.registration, required this.model});

  factory Aircraft.fromJson(Map<String, dynamic> json) {
    return Aircraft(
      model: json['model'] ?? 'Unknown', // Ensure model is never null
      registration: (json['registration'] == null || json['registration'] == "N/A")
          ? 'Unknown'
          : json['registration'], // Convert null or "N/A" to 'Unknown'
    );
  }
}

class FlightEvent {
  final EventType type;
  final DateTime time;
  final bool completed;

  FlightEvent({required this.type, required this.time, required this.completed});

  factory FlightEvent.fromJson(Map<String, dynamic> json) {
    return FlightEvent(
      type: EventType.values.firstWhere(
            (e) => e.toString().split('.').last == json['type'],
        orElse: () => EventType.unknown,
      ),
      time: DateTime.tryParse(json['time'] ?? '') ?? DateTime.now(),
      completed: json['completed'] ?? false,
    );
  }
}

class Flight {
  final String flightNumber;
  final Airline airline;
  final Airport origin;
  final Airport destination;
  final FlightTime departure;
  final FlightTime arrival;
  final FlightStatus status;
  final int? delayMinutes;
  final Aircraft? aircraft;
  // final List<FlightEvent> events;
  // final double progressPercent;

  Flight({
    required this.flightNumber,
    required this.airline,
    required this.origin,
    required this.destination,
    required this.departure,
    required this.arrival,
    required this.status,
    this.delayMinutes,
    this.aircraft,
    // required this.events,
    // required this.progressPercent,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightNumber: json['flightNumber'] ?? '',

      airline: Airline.fromJson({
        "iata": json['iata'],
        "airlineName": json['airlineName'],
      }),

      origin: Airport.fromJson(json['origin'] ?? {}),
      destination: Airport.fromJson(json['destination'] ?? {}),

      departure: FlightTime.fromJson({
        'scheduled': json['scheduledDeparture'],
        'estimated': json['estimatedDeparture'],
        'actual': json['actualDeparture'] != 'N/A' ? json['actualDeparture'] : null
      }),
      arrival: FlightTime.fromJson({
        'scheduled': json['scheduledArrival'],
        'estimated': json['estimatedArrival'],
        'actual': json['actualArrival'] != 'N/A' ? json['actualArrival'] : null
      }),

      // Ensure status parsing is handled correctly
      status: _parseFlightStatus(json['status']),

      // Fix delayMinutes (if missing, default to 0)
      delayMinutes: json['delayMinutes'] ?? 0,

      // Handle aircraft (if missing, use default values)
      aircraft: json['aircraft'] != null && json['aircraft'] is Map<String, dynamic>
          ? Aircraft.fromJson(json['aircraft'])
          : Aircraft(model: "Unknown", registration: "Unknown"), // Provide default aircraft if needed
    );
  }

  static FlightStatus _parseFlightStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'on time':
        return FlightStatus.onTime;
      case 'delayed':
        return FlightStatus.delayed;
      case 'boarding':
        return FlightStatus.boarding;
      case 'departed':
        return FlightStatus.departed;
      case 'in air':
        return FlightStatus.inAir;
      case 'arrived':
        return FlightStatus.arrived;
      case 'cancelled':
        return FlightStatus.cancelled;
      default:
        return FlightStatus.unknown;
    }
  }
}
